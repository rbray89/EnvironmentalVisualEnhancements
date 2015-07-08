Shader "EVE/Ocean" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_UnderColor ("Color Tint", Color) = (1,1,1,1)
		_SpecColor ("Specular tint", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_MainTexHandoverDist ("Handover Distance", Float) = 1
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_Clarity ("Clarity", Range(0,1)) = .005
		_LightPower ("LightPower", Float) = 1.75
		_Reflectivity ("Reflectivity", Float) = .08
	}
	
SubShader {

Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout"}
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Back Lighting On
		
		//surface
		Pass {
		Lighting On
		ZWrite On
		Tags { "LightMode"="ForwardBase"}
		
		Program "vp" {
// Vertex combos: 15
//   d3d9 - ALU: 26 to 35
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w;
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
def c13, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c13.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o5.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_LightTexture0, vec2(tmpvar_47)).w;
  mediump float tmpvar_49;
  tmpvar_49 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_48), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_49)), 0.0, 1.0);
  light_3 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_51;
  mediump vec3 tmpvar_52;
  mediump vec3 i_53;
  i_53 = -(lightDirection_5);
  tmpvar_52 = (i_53 - (2.0 * (dot (normalDir_4, i_53) * normalDir_4)));
  highp vec3 tmpvar_54;
  tmpvar_54 = (specularReflection_2 * (((tmpvar_48 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_52, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (light_3 + (tex_9.w * tmpvar_54));
  light_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_57);
  highp vec3 tmpvar_58;
  tmpvar_58 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_58;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_LightTexture0, vec2(tmpvar_47)).w;
  mediump float tmpvar_49;
  tmpvar_49 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_48), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_49)), 0.0, 1.0);
  light_3 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_51;
  mediump vec3 tmpvar_52;
  mediump vec3 i_53;
  i_53 = -(lightDirection_5);
  tmpvar_52 = (i_53 - (2.0 * (dot (normalDir_4, i_53) * normalDir_4)));
  highp vec3 tmpvar_54;
  tmpvar_54 = (specularReflection_2 * (((tmpvar_48 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_52, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (light_3 + (tex_9.w * tmpvar_54));
  light_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_57);
  highp vec3 tmpvar_58;
  tmpvar_58 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_58;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 388
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
};
#line 477
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 398
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 411
#line 419
#line 433
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 466
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 470
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 474
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 495
#line 495
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 499
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 503
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 507
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 388
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
};
#line 477
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 398
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 411
#line 419
#line 433
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 466
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 470
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 474
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 495
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 509
lowp vec4 frag( in v2f IN ) {
    #line 511
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 515
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 519
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 523
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 527
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 531
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 535
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  vec3 i_27;
  i_27 = -(tmpvar_25.xyz);
  vec3 tmpvar_28;
  tmpvar_28 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp (((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot ((i_27 - (2.0 * (dot (xlv_TEXCOORD2, i_27) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_28) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_28));
  color_2.xyz = (color_2.xyz * tmpvar_28);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord5 o4
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c9.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
mov r0.zw, v3.xyxy
mov r0.xy, v2
dp4 r0.w, r0, r0
rsq r1.w, r0.w
mul r0.xyz, r1.w, r0
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r1.xyz, -r1, c8
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mov o4.xyz, -r0
mul o2.xyz, r0.w, r1
rcp o1.x, r0.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = clamp (((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_5);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_4, i_51) * normalDir_4)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_2 * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_3 + (tex_9.w * tmpvar_52));
  light_3 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_54);
  highp vec3 tmpvar_55;
  tmpvar_55 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_56;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  mediump float tmpvar_47;
  tmpvar_47 = clamp (((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0), 0.0, 1.0);
  highp vec3 tmpvar_48;
  tmpvar_48 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_47)), 0.0, 1.0);
  light_3 = tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_49;
  mediump vec3 tmpvar_50;
  mediump vec3 i_51;
  i_51 = -(lightDirection_5);
  tmpvar_50 = (i_51 - (2.0 * (dot (normalDir_4, i_51) * normalDir_4)));
  highp vec3 tmpvar_52;
  tmpvar_52 = (specularReflection_2 * ((_LightColor0.xyz * _SpecColor.xyz) * pow (clamp (dot (tmpvar_50, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (light_3 + (tex_9.w * tmpvar_52));
  light_3 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_54);
  highp vec3 tmpvar_55;
  tmpvar_55 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_56;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 386
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 483
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 sphereNormal;
};
#line 475
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 396
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 409
#line 417
#line 431
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 464
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 468
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 472
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 492
#line 505
#line 492
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 496
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 500
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 386
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 483
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 sphereNormal;
};
#line 475
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 396
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 409
#line 417
#line 431
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 464
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 468
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 472
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 492
#line 505
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 505
lowp vec4 frag( in v2f IN ) {
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    #line 509
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    #line 513
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    #line 517
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = 1.0;
    #line 521
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    #line 525
    light += (main.w * specularReflection);
    color.w = 1.0;
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    #line 529
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    #line 533
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w);
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
def c13, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c13.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o5.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.w, r0, c11
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  highp float tmpvar_52;
  tmpvar_52 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w);
  atten_4 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = clamp ((((_LightColor0.w * ((tmpvar_47 - 0.01) / 0.99)) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_54;
  tmpvar_54 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_53)), 0.0, 1.0);
  light_3 = tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_55;
  mediump vec3 tmpvar_56;
  mediump vec3 i_57;
  i_57 = -(lightDirection_6);
  tmpvar_56 = (i_57 - (2.0 * (dot (normalDir_5, i_57) * normalDir_5)));
  highp vec3 tmpvar_58;
  tmpvar_58 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_56, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (light_3 + (tex_10.w * tmpvar_58));
  light_3 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_60);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_61);
  highp vec3 tmpvar_62;
  tmpvar_62 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_62;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_48 = texture2D (_LightTexture0, P_49);
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_LightTextureB0, vec2(tmpvar_50));
  highp float tmpvar_52;
  tmpvar_52 = ((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w);
  atten_4 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = clamp ((((_LightColor0.w * ((tmpvar_47 - 0.01) / 0.99)) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_54;
  tmpvar_54 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_53)), 0.0, 1.0);
  light_3 = tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_55;
  mediump vec3 tmpvar_56;
  mediump vec3 i_57;
  i_57 = -(lightDirection_6);
  tmpvar_56 = (i_57 - (2.0 * (dot (normalDir_5, i_57) * normalDir_5)));
  highp vec3 tmpvar_58;
  tmpvar_58 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_56, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (light_3 + (tex_10.w * tmpvar_58));
  light_3 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_60);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_61);
  highp vec3 tmpvar_62;
  tmpvar_62 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_62;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 397
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 494
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec3 sphereNormal;
};
#line 486
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 407
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 420
#line 428
#line 442
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 475
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 479
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 483
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 504
#line 504
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 508
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 512
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 516
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 397
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 494
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec3 sphereNormal;
};
#line 486
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 407
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 420
#line 428
#line 442
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 475
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 479
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 483
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 504
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 393
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 395
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 389
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 391
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 518
lowp vec4 frag( in v2f IN ) {
    #line 520
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 524
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 528
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 532
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 536
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 540
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 544
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 30 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
def c13, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c13.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o5.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_48;
  tmpvar_48 = (texture2D (_LightTextureB0, vec2(tmpvar_47)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump float tmpvar_49;
  tmpvar_49 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_48), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_49)), 0.0, 1.0);
  light_3 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_51;
  mediump vec3 tmpvar_52;
  mediump vec3 i_53;
  i_53 = -(lightDirection_5);
  tmpvar_52 = (i_53 - (2.0 * (dot (normalDir_4, i_53) * normalDir_4)));
  highp vec3 tmpvar_54;
  tmpvar_54 = (specularReflection_2 * (((tmpvar_48 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_52, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (light_3 + (tex_9.w * tmpvar_54));
  light_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_57);
  highp vec3 tmpvar_58;
  tmpvar_58 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_58;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  highp float tmpvar_47;
  tmpvar_47 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp float tmpvar_48;
  tmpvar_48 = (texture2D (_LightTextureB0, vec2(tmpvar_47)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
  mediump float tmpvar_49;
  tmpvar_49 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_48), 0.0, 1.0);
  highp vec3 tmpvar_50;
  tmpvar_50 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_49)), 0.0, 1.0);
  light_3 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_51;
  mediump vec3 tmpvar_52;
  mediump vec3 i_53;
  i_53 = -(lightDirection_5);
  tmpvar_52 = (i_53 - (2.0 * (dot (normalDir_4, i_53) * normalDir_4)));
  highp vec3 tmpvar_54;
  tmpvar_54 = (specularReflection_2 * (((tmpvar_48 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_52, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_54;
  highp vec3 tmpvar_55;
  tmpvar_55 = (light_3 + (tex_9.w * tmpvar_54));
  light_3 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_57);
  highp vec3 tmpvar_58;
  tmpvar_58 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_58;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 389
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 486
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
};
#line 478
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 399
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 412
#line 420
#line 434
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 467
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 471
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 475
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 496
#line 496
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 500
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 504
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 508
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 389
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 486
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 sphereNormal;
};
#line 478
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 399
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 412
#line 420
#line 434
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 467
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 471
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 475
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 496
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 510
lowp vec4 frag( in v2f IN ) {
    #line 512
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 516
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 520
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 524
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 528
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 532
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 536
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
def c13, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c13.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o5.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  mediump float tmpvar_48;
  tmpvar_48 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_47), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_48)), 0.0, 1.0);
  light_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_50;
  mediump vec3 tmpvar_51;
  mediump vec3 i_52;
  i_52 = -(lightDirection_5);
  tmpvar_51 = (i_52 - (2.0 * (dot (normalDir_4, i_52) * normalDir_4)));
  highp vec3 tmpvar_53;
  tmpvar_53 = (specularReflection_2 * (((tmpvar_47 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_51, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (light_3 + (tex_9.w * tmpvar_53));
  light_3 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_57;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
  mediump float tmpvar_48;
  tmpvar_48 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_47), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_48)), 0.0, 1.0);
  light_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_50;
  mediump vec3 tmpvar_51;
  mediump vec3 i_52;
  i_52 = -(lightDirection_5);
  tmpvar_51 = (i_52 - (2.0 * (dot (normalDir_4, i_52) * normalDir_4)));
  highp vec3 tmpvar_53;
  tmpvar_53 = (specularReflection_2 * (((tmpvar_47 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_51, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (light_3 + (tex_9.w * tmpvar_53));
  light_3 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_57;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 388
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec3 sphereNormal;
};
#line 477
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 398
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 411
#line 419
#line 433
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 466
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 470
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 474
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 495
#line 495
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 499
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 503
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 507
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 388
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 485
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec3 sphereNormal;
};
#line 477
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 398
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 411
#line 419
#line 433
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 466
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 470
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 474
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 495
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 509
lowp vec4 frag( in v2f IN ) {
    #line 511
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 515
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 519
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 523
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, IN._LightCoord).w * 1.0);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 527
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 531
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 535
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_29;
  tmpvar_29 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  float tmpvar_31;
  if ((tmpvar_30.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_31 = _LightShadowData.x;
  } else {
    tmpvar_31 = 1.0;
  };
  float tmpvar_32;
  tmpvar_32 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_28.w) * tmpvar_29.w) * tmpvar_31);
  vec3 i_33;
  i_33 = -(tmpvar_25.xyz);
  vec3 tmpvar_34;
  tmpvar_34 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_32), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_32 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_33 - (2.0 * (dot (xlv_TEXCOORD2, i_33) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_34) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_34));
  color_2.xyz = (color_2.xyz * tmpvar_34);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c17.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c16
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c11
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_49 = texture2D (_LightTexture0, P_50);
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_LightTextureB0, vec2(tmpvar_51));
  lowp float tmpvar_53;
  mediump float shadow_54;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_56;
  if ((tmpvar_55.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_56 = _LightShadowData.x;
  } else {
    tmpvar_56 = 1.0;
  };
  shadow_54 = tmpvar_56;
  tmpvar_53 = shadow_54;
  highp float tmpvar_57;
  tmpvar_57 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_49.w) * tmpvar_52.w) * tmpvar_53);
  atten_4 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_58)), 0.0, 1.0);
  light_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_60;
  mediump vec3 tmpvar_61;
  mediump vec3 i_62;
  i_62 = -(lightDirection_6);
  tmpvar_61 = (i_62 - (2.0 * (dot (normalDir_5, i_62) * normalDir_5)));
  highp vec3 tmpvar_63;
  tmpvar_63 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_61, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = (light_3 + (tex_10.w * tmpvar_63));
  light_3 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_66);
  highp vec3 tmpvar_67;
  tmpvar_67 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_67;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_49 = texture2D (_LightTexture0, P_50);
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_LightTextureB0, vec2(tmpvar_51));
  lowp float tmpvar_53;
  mediump float shadow_54;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4);
  highp float tmpvar_56;
  if ((tmpvar_55.x < (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))) {
    tmpvar_56 = _LightShadowData.x;
  } else {
    tmpvar_56 = 1.0;
  };
  shadow_54 = tmpvar_56;
  tmpvar_53 = shadow_54;
  highp float tmpvar_57;
  tmpvar_57 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_49.w) * tmpvar_52.w) * tmpvar_53);
  atten_4 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_58)), 0.0, 1.0);
  light_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_60;
  mediump vec3 tmpvar_61;
  mediump vec3 i_62;
  i_62 = -(lightDirection_6);
  tmpvar_61 = (i_62 - (2.0 * (dot (normalDir_5, i_62) * normalDir_5)));
  highp vec3 tmpvar_63;
  tmpvar_63 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_61, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = (light_3 + (tex_10.w * tmpvar_63));
  light_3 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_66);
  highp vec3 tmpvar_67;
  tmpvar_67 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_67;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 403
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 500
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 492
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 394
uniform sampler2D _LightTextureB0;
#line 399
#line 413
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 426
#line 434
#line 448
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 481
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 485
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 489
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 511
#line 511
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 515
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 519
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 524
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 403
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 500
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 492
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 394
uniform sampler2D _LightTextureB0;
#line 399
#line 413
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 426
#line 434
#line 448
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 481
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 485
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 489
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 511
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 399
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 395
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 387
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 390
    return shadow;
}
#line 526
lowp vec4 frag( in v2f IN ) {
    #line 528
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 532
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 536
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 540
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 544
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 548
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 552
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = (((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w) * (_LightShadowData.x + (shadow2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x * (1.0 - _LightShadowData.x))));
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c17.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c16
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c11
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
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
  lowp float tmpvar_54;
  tmpvar_54 = shadow2DProjEXT (_ShadowMapTexture, xlv_TEXCOORD4);
  shadow_53 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = (_LightShadowData.x + (shadow_53 * (1.0 - _LightShadowData.x)));
  shadow_53 = tmpvar_55;
  tmpvar_52 = shadow_53;
  highp float tmpvar_56;
  tmpvar_56 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * ((tmpvar_47 - 0.01) / 0.99)) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_3 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_6);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_5, i_61) * normalDir_5)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_3 + (tex_10.w * tmpvar_62));
  light_3 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_64);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_66;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 404
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 501
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 493
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 394
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 414
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 427
#line 435
#line 449
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 482
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 486
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 490
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 512
#line 512
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 516
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 520
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 525
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 404
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 501
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 493
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 394
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 414
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 427
#line 435
#line 449
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 482
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 486
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 490
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 512
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 400
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    #line 402
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 396
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    #line 398
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 387
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 390
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 527
lowp vec4 frag( in v2f IN ) {
    #line 529
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 533
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 537
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 541
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 545
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 549
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 553
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  vec4 tmpvar_4;
  tmpvar_4.x = gl_MultiTexCoord0.x;
  tmpvar_4.y = gl_MultiTexCoord0.y;
  tmpvar_4.z = gl_MultiTexCoord1.x;
  tmpvar_4.w = gl_MultiTexCoord1.y;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_3).xyz);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD5 = -(normalize(tmpvar_4).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27.x), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27.x * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord5 o5
def c11, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c11.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
mov r1.zw, v3.xyxy
mov r1.xy, v2
dp4 r0.z, r1, r1
dp4 r0.w, v0, c3
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c11.y
mul r2.y, r2, c9.x
rsq r0.z, r0.z
mad o4.xy, r2.z, c10.zwzw, r2
mul r2.xyz, r0.z, r1
dp4 r0.z, v0, c2
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r1.xyz, -r1, c8
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mov o5.xyz, -r2
mov o0, r0
mul o2.xyz, r1.w, r1
mov o4.zw, r0
rcp o1.x, r1.w
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_47), 0.0, 1.0);
  highp vec3 tmpvar_54;
  tmpvar_54 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_53)), 0.0, 1.0);
  light_3 = tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_55;
  mediump vec3 tmpvar_56;
  mediump vec3 i_57;
  i_57 = -(lightDirection_5);
  tmpvar_56 = (i_57 - (2.0 * (dot (normalDir_4, i_57) * normalDir_4)));
  highp vec3 tmpvar_58;
  tmpvar_58 = (specularReflection_2 * (((tmpvar_47 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_56, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = (light_3 + (tex_9.w * tmpvar_58));
  light_3 = tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_60);
  highp vec3 tmpvar_61;
  tmpvar_61 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_61);
  highp vec3 tmpvar_62;
  tmpvar_62 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_62;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_2;
  p_2 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_4;
  tmpvar_4.x = _glesMultiTexCoord0.x;
  tmpvar_4.y = _glesMultiTexCoord0.y;
  tmpvar_4.z = _glesMultiTexCoord1.x;
  tmpvar_4.w = _glesMultiTexCoord1.y;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_3).xyz);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD5 = -(normalize(tmpvar_4).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  mediump float tmpvar_48;
  tmpvar_48 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_47.x), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_48)), 0.0, 1.0);
  light_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_50;
  mediump vec3 tmpvar_51;
  mediump vec3 i_52;
  i_52 = -(lightDirection_5);
  tmpvar_51 = (i_52 - (2.0 * (dot (normalDir_4, i_52) * normalDir_4)));
  highp vec3 tmpvar_53;
  tmpvar_53 = (specularReflection_2 * (((tmpvar_47.x * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_51, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (light_3 + (tex_9.w * tmpvar_53));
  light_3 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_57;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 394
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 491
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 483
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 404
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 417
#line 425
#line 439
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 472
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 476
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 480
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 501
#line 501
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 505
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 509
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 513
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 394
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 491
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 483
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 404
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 417
#line 425
#line 439
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 472
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 476
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 480
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 501
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 388
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 390
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 515
lowp vec4 frag( in v2f IN ) {
    #line 517
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 521
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 525
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 529
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 533
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 537
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 541
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.viewDist = float(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.worldNormal = vec3(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xlt_IN.sphereNormal = vec3(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 p_2;
  p_2 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = gl_Normal;
  vec4 tmpvar_4;
  tmpvar_4.x = gl_MultiTexCoord0.x;
  tmpvar_4.y = gl_MultiTexCoord0.y;
  tmpvar_4.z = gl_MultiTexCoord1.x;
  tmpvar_4.w = gl_MultiTexCoord1.y;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_3).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
  xlv_TEXCOORD4 = o_5;
  xlv_TEXCOORD5 = -(normalize(tmpvar_4).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform float _Shininess;
uniform vec4 _Color;
uniform vec4 _SpecColor;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x);
  vec3 i_28;
  i_28 = -(tmpvar_25.xyz);
  vec3 tmpvar_29;
  tmpvar_29 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_27), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_27 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_28 - (2.0 * (dot (xlv_TEXCOORD2, i_28) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_29) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_29));
  color_2.xyz = (color_2.xyz * tmpvar_29);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 34 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c15, 0.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mov r0.w, c15.x
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
dp3 r0.x, r1, r1
rsq r1.w, r0.x
mul o3.xyz, r1.w, r1
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c15.y
mul r2.y, r2, c13.x
mov r0.zw, v3.xyxy
mov r0.xy, v2
dp4 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o6.xyz, -r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mad o5.xy, r2.z, c14.zwzw, r2
add r2.xyz, -r0, c12
dp3 r0.w, r2, r2
mov o0, r1
rsq r1.x, r0.w
dp4 r0.w, v0, c7
mul o2.xyz, r1.x, r2
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
mov o5.zw, r1
rcp o1.x, r1.x
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp float tmpvar_47;
  mediump float lightShadowDataX_48;
  highp float dist_49;
  lowp float tmpvar_50;
  tmpvar_50 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = _LightShadowData.x;
  lightShadowDataX_48 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = max (float((dist_49 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_48);
  tmpvar_47 = tmpvar_52;
  lowp float tmpvar_53;
  tmpvar_53 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * tmpvar_47);
  mediump float tmpvar_54;
  tmpvar_54 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_53), 0.0, 1.0);
  highp vec3 tmpvar_55;
  tmpvar_55 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_54)), 0.0, 1.0);
  light_3 = tmpvar_55;
  mediump vec3 tmpvar_56;
  tmpvar_56 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_56;
  mediump vec3 tmpvar_57;
  mediump vec3 i_58;
  i_58 = -(lightDirection_5);
  tmpvar_57 = (i_58 - (2.0 * (dot (normalDir_4, i_58) * normalDir_4)));
  highp vec3 tmpvar_59;
  tmpvar_59 = (specularReflection_2 * (((tmpvar_53 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_57, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = (light_3 + (tex_9.w * tmpvar_59));
  light_3 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_61);
  highp vec3 tmpvar_62;
  tmpvar_62 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_62);
  highp vec3 tmpvar_63;
  tmpvar_63 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_63;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec3 p_2;
  p_2 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_4;
  tmpvar_4.x = _glesMultiTexCoord0.x;
  tmpvar_4.y = _glesMultiTexCoord0.y;
  tmpvar_4.z = _glesMultiTexCoord1.x;
  tmpvar_4.w = _glesMultiTexCoord1.y;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = sqrt(dot (p_2, p_2));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_3).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
  xlv_TEXCOORD4 = o_5;
  xlv_TEXCOORD5 = -(normalize(tmpvar_4).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _MainTex;
uniform highp float _Shininess;
uniform lowp vec4 _Color;
uniform lowp vec4 _SpecColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 glstate_lightmodel_ambient;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  mediump vec3 normalDir_4;
  mediump vec3 lightDirection_5;
  mediump vec3 ambientLighting_6;
  mediump float detailLevel_7;
  mediump vec4 color_8;
  mediump vec4 tex_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_11;
  highp float r_12;
  if ((abs(tmpvar_10.z) > (1e-08 * abs(tmpvar_10.x)))) {
    highp float y_over_x_13;
    y_over_x_13 = (tmpvar_10.x / tmpvar_10.z);
    highp float s_14;
    highp float x_15;
    x_15 = (y_over_x_13 * inversesqrt(((y_over_x_13 * y_over_x_13) + 1.0)));
    s_14 = (sign(x_15) * (1.5708 - (sqrt((1.0 - abs(x_15))) * (1.5708 + (abs(x_15) * (-0.214602 + (abs(x_15) * (0.0865667 + (abs(x_15) * -0.0310296)))))))));
    r_12 = s_14;
    if ((tmpvar_10.z < 0.0)) {
      if ((tmpvar_10.x >= 0.0)) {
        r_12 = (s_14 + 3.14159);
      } else {
        r_12 = (r_12 - 3.14159);
      };
    };
  } else {
    r_12 = (sign(tmpvar_10.x) * 1.5708);
  };
  uv_11.x = (0.5 + (0.159155 * r_12));
  uv_11.y = (0.31831 * (1.5708 - (sign(tmpvar_10.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_10.y))) * (1.5708 + (abs(tmpvar_10.y) * (-0.214602 + (abs(tmpvar_10.y) * (0.0865667 + (abs(tmpvar_10.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_10.xz);
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_10.xz);
  highp vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(uv_11.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(uv_11.y);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DGradEXT (_MainTex, uv_11, tmpvar_18.xy, tmpvar_18.zw);
  tex_9 = tmpvar_19;
  mediump vec4 tmpvar_20;
  mediump vec3 detailCoords_21;
  mediump float nylerp_22;
  mediump float zxlerp_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_25;
  highp float r_26;
  if ((abs(tmpvar_24.z) > (1e-08 * abs(tmpvar_24.x)))) {
    highp float y_over_x_27;
    y_over_x_27 = (tmpvar_24.x / tmpvar_24.z);
    highp float s_28;
    highp float x_29;
    x_29 = (y_over_x_27 * inversesqrt(((y_over_x_27 * y_over_x_27) + 1.0)));
    s_28 = (sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296)))))))));
    r_26 = s_28;
    if ((tmpvar_24.z < 0.0)) {
      if ((tmpvar_24.x >= 0.0)) {
        r_26 = (s_28 + 3.14159);
      } else {
        r_26 = (r_26 - 3.14159);
      };
    };
  } else {
    r_26 = (sign(tmpvar_24.x) * 1.5708);
  };
  uv_25.x = (0.5 + (0.159155 * r_26));
  uv_25.y = (0.31831 * (1.5708 - (sign(tmpvar_24.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_24.y))) * (1.5708 + (abs(tmpvar_24.y) * (-0.214602 + (abs(tmpvar_24.y) * (0.0865667 + (abs(tmpvar_24.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdx(tmpvar_24.xz);
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdy(tmpvar_24.xz);
  highp vec4 tmpvar_32;
  tmpvar_32.x = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_32.y = dFdx(uv_25.y);
  tmpvar_32.z = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_32.w = dFdy(uv_25.y);
  highp vec3 tmpvar_33;
  tmpvar_33 = abs(tmpvar_24);
  highp float tmpvar_34;
  tmpvar_34 = float((tmpvar_33.z >= tmpvar_33.x));
  zxlerp_23 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = float((mix (tmpvar_33.x, tmpvar_33.z, zxlerp_23) >= tmpvar_33.y));
  nylerp_22 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_33, tmpvar_33.zxy, vec3(zxlerp_23));
  detailCoords_21 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33.yxz, detailCoords_21, vec3(nylerp_22));
  detailCoords_21 = tmpvar_37;
  mediump float tmpvar_38;
  tmpvar_38 = abs(detailCoords_21.x);
  highp vec2 coord_39;
  coord_39 = (((0.5 * detailCoords_21.zy) / tmpvar_38) * _DetailScale);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DGradEXT (_DetailTex, coord_39, tmpvar_32.xy, tmpvar_32.zw);
  tmpvar_20 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (mix (mix (tmpvar_20, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_7)), tex_9, vec4(tmpvar_42)) * _Color);
  color_8.xyz = tmpvar_43.xyz;
  highp vec3 tmpvar_44;
  tmpvar_44 = glstate_lightmodel_ambient.xyz;
  ambientLighting_6 = tmpvar_44;
  lowp vec3 tmpvar_45;
  tmpvar_45 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_5 = tmpvar_45;
  normalDir_4 = xlv_TEXCOORD2;
  mediump float tmpvar_46;
  tmpvar_46 = clamp (dot (normalDir_4, lightDirection_5), 0.0, 1.0);
  lowp float tmpvar_47;
  tmpvar_47 = (texture2D (_LightTexture0, xlv_TEXCOORD3).w * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x);
  mediump float tmpvar_48;
  tmpvar_48 = clamp ((((_LightColor0.w * ((tmpvar_46 - 0.01) / 0.99)) * 4.0) * tmpvar_47), 0.0, 1.0);
  highp vec3 tmpvar_49;
  tmpvar_49 = clamp ((ambientLighting_6 + ((_MinLight + _LightColor0.xyz) * tmpvar_48)), 0.0, 1.0);
  light_3 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3(clamp (floor((1.0 + tmpvar_46)), 0.0, 1.0));
  specularReflection_2 = tmpvar_50;
  mediump vec3 tmpvar_51;
  mediump vec3 i_52;
  i_52 = -(lightDirection_5);
  tmpvar_51 = (i_52 - (2.0 * (dot (normalDir_4, i_52) * normalDir_4)));
  highp vec3 tmpvar_53;
  tmpvar_53 = (specularReflection_2 * (((tmpvar_47 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_51, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (light_3 + (tex_9.w * tmpvar_53));
  light_3 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_8.w = mix (0.4489, tex_9.w, tmpvar_55);
  highp vec3 tmpvar_56;
  tmpvar_56 = clamp (((_LightPower * light_3) - color_8.w), 0.0, 1.0);
  color_8.xyz = (tmpvar_43.xyz * tmpvar_56);
  highp vec3 tmpvar_57;
  tmpvar_57 = (color_8.xyz + (_Reflectivity * light_3));
  color_8.xyz = tmpvar_57;
  color_8.xyz = (color_8.xyz * light_3);
  tmpvar_1 = color_8;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 396
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 493
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 485
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 394
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 406
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 419
#line 427
#line 441
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 474
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 478
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 482
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 504
#line 504
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 508
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 512
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 517
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 396
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 493
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec2 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 485
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 394
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 406
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 419
#line 427
#line 441
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 474
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 478
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 482
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 504
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 388
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 390
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 519
lowp vec4 frag( in v2f IN ) {
    #line 521
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 525
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 529
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 533
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, IN._LightCoord).w * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 537
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 541
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 545
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  float tmpvar_29;
  tmpvar_29 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_30;
  tmpvar_30 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_31;
  if ((tmpvar_30 < tmpvar_29)) {
    tmpvar_31 = _LightShadowData.x;
  } else {
    tmpvar_31 = 1.0;
  };
  float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w * tmpvar_31);
  vec3 i_33;
  i_33 = -(tmpvar_25.xyz);
  vec3 tmpvar_34;
  tmpvar_34 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_32), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_32 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_33 - (2.0 * (dot (xlv_TEXCOORD2, i_33) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_34) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_34));
  color_2.xyz = (color_2.xyz * tmpvar_34);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c14.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
add o5.xyz, r0, -c13
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTexture0, vec2(tmpvar_49));
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
  tmpvar_56 = (tmpvar_50.w * tmpvar_55);
  atten_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_3 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_6);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_5, i_61) * normalDir_5)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_3 + (tex_10.w * tmpvar_62));
  light_3 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_64);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_66;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTexture0, vec2(tmpvar_49));
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
  tmpvar_56 = (tmpvar_50.w * tmpvar_55);
  atten_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_58;
  tmpvar_58 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_57)), 0.0, 1.0);
  light_3 = tmpvar_58;
  mediump vec3 tmpvar_59;
  tmpvar_59 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_59;
  mediump vec3 tmpvar_60;
  mediump vec3 i_61;
  i_61 = -(lightDirection_6);
  tmpvar_60 = (i_61 - (2.0 * (dot (normalDir_5, i_61) * normalDir_5)));
  highp vec3 tmpvar_62;
  tmpvar_62 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_60, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_62;
  highp vec3 tmpvar_63;
  tmpvar_63 = (light_3 + (tex_10.w * tmpvar_62));
  light_3 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_64);
  highp vec3 tmpvar_65;
  tmpvar_65 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_66;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 498
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 490
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
#line 399
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 479
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 487
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 509
#line 509
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 513
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 517
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 522
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 401
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 498
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 490
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
#line 399
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 411
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 424
#line 432
#line 446
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 479
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 483
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 487
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 509
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 387
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 390
    return DecodeFloatRGBA( packDist);
}
#line 392
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 394
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 524
lowp vec4 frag( in v2f IN ) {
    #line 526
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 530
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 534
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 538
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 542
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 546
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 550
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_29;
  tmpvar_29 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  float tmpvar_30;
  tmpvar_30 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  float tmpvar_31;
  tmpvar_31 = dot (textureCube (_ShadowMapTexture, xlv_TEXCOORD4), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  float tmpvar_32;
  if ((tmpvar_31 < tmpvar_30)) {
    tmpvar_32 = _LightShadowData.x;
  } else {
    tmpvar_32 = 1.0;
  };
  float tmpvar_33;
  tmpvar_33 = ((tmpvar_28.w * tmpvar_29.w) * tmpvar_32);
  vec3 i_34;
  i_34 = -(tmpvar_25.xyz);
  vec3 tmpvar_35;
  tmpvar_35 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_33), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_33 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_34 - (2.0 * (dot (xlv_TEXCOORD2, i_34) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_35) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_35));
  color_2.xyz = (color_2.xyz * tmpvar_35);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c14.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
add o5.xyz, r0, -c13
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTextureB0, vec2(tmpvar_49));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_52;
  tmpvar_52 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_53 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = dot (packDist_53, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_56;
  if ((tmpvar_55 < tmpvar_52)) {
    tmpvar_56 = _LightShadowData.x;
  } else {
    tmpvar_56 = 1.0;
  };
  highp float tmpvar_57;
  tmpvar_57 = ((tmpvar_50.w * tmpvar_51.w) * tmpvar_56);
  atten_4 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_58)), 0.0, 1.0);
  light_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_60;
  mediump vec3 tmpvar_61;
  mediump vec3 i_62;
  i_62 = -(lightDirection_6);
  tmpvar_61 = (i_62 - (2.0 * (dot (normalDir_5, i_62) * normalDir_5)));
  highp vec3 tmpvar_63;
  tmpvar_63 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_61, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = (light_3 + (tex_10.w * tmpvar_63));
  light_3 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_66);
  highp vec3 tmpvar_67;
  tmpvar_67 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_67;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTextureB0, vec2(tmpvar_49));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_52;
  tmpvar_52 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec4 packDist_53;
  lowp vec4 tmpvar_54;
  tmpvar_54 = textureCube (_ShadowMapTexture, xlv_TEXCOORD4);
  packDist_53 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = dot (packDist_53, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_56;
  if ((tmpvar_55 < tmpvar_52)) {
    tmpvar_56 = _LightShadowData.x;
  } else {
    tmpvar_56 = 1.0;
  };
  highp float tmpvar_57;
  tmpvar_57 = ((tmpvar_50.w * tmpvar_51.w) * tmpvar_56);
  atten_4 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_59;
  tmpvar_59 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_58)), 0.0, 1.0);
  light_3 = tmpvar_59;
  mediump vec3 tmpvar_60;
  tmpvar_60 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_60;
  mediump vec3 tmpvar_61;
  mediump vec3 i_62;
  i_62 = -(lightDirection_6);
  tmpvar_61 = (i_62 - (2.0 * (dot (normalDir_5, i_62) * normalDir_5)));
  highp vec3 tmpvar_63;
  tmpvar_63 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_61, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_63;
  highp vec3 tmpvar_64;
  tmpvar_64 = (light_3 + (tex_10.w * tmpvar_63));
  light_3 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_65);
  highp vec3 tmpvar_66;
  tmpvar_66 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_66);
  highp vec3 tmpvar_67;
  tmpvar_67 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_67;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 402
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 491
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
#line 399
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 412
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 425
#line 433
#line 447
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 480
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 484
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 488
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 510
#line 510
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 514
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 518
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 523
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 402
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 499
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 491
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
#line 399
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 412
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 425
#line 433
#line 447
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 480
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 484
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 488
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 510
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 387
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 390
    return DecodeFloatRGBA( packDist);
}
#line 392
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 394
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 525
lowp vec4 frag( in v2f IN ) {
    #line 527
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 531
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 535
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 539
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 543
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 547
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 551
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
  vec4 tmpvar_29;
  tmpvar_29 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
  vec4 shadowVals_30;
  vec3 tmpvar_31;
  tmpvar_31 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  shadowVals_30.x = texture2D (_ShadowMapTexture, (tmpvar_31.xy + _ShadowOffsets[0].xy)).x;
  shadowVals_30.y = texture2D (_ShadowMapTexture, (tmpvar_31.xy + _ShadowOffsets[1].xy)).x;
  shadowVals_30.z = texture2D (_ShadowMapTexture, (tmpvar_31.xy + _ShadowOffsets[2].xy)).x;
  shadowVals_30.w = texture2D (_ShadowMapTexture, (tmpvar_31.xy + _ShadowOffsets[3].xy)).x;
  bvec4 tmpvar_32;
  tmpvar_32 = lessThan (shadowVals_30, tmpvar_31.zzzz);
  vec4 tmpvar_33;
  tmpvar_33 = _LightShadowData.xxxx;
  float tmpvar_34;
  if (tmpvar_32.x) {
    tmpvar_34 = tmpvar_33.x;
  } else {
    tmpvar_34 = 1.0;
  };
  float tmpvar_35;
  if (tmpvar_32.y) {
    tmpvar_35 = tmpvar_33.y;
  } else {
    tmpvar_35 = 1.0;
  };
  float tmpvar_36;
  if (tmpvar_32.z) {
    tmpvar_36 = tmpvar_33.z;
  } else {
    tmpvar_36 = 1.0;
  };
  float tmpvar_37;
  if (tmpvar_32.w) {
    tmpvar_37 = tmpvar_33.w;
  } else {
    tmpvar_37 = 1.0;
  };
  vec4 tmpvar_38;
  tmpvar_38.x = tmpvar_34;
  tmpvar_38.y = tmpvar_35;
  tmpvar_38.z = tmpvar_36;
  tmpvar_38.w = tmpvar_37;
  float tmpvar_39;
  tmpvar_39 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_28.w) * tmpvar_29.w) * dot (tmpvar_38, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_40;
  i_40 = -(tmpvar_25.xyz);
  vec3 tmpvar_41;
  tmpvar_41 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_39), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_39 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_40 - (2.0 * (dot (xlv_TEXCOORD2, i_40) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_41) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_41));
  color_2.xyz = (color_2.xyz * tmpvar_41);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c17.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c16
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c11
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_49 = texture2D (_LightTexture0, P_50);
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_LightTextureB0, vec2(tmpvar_51));
  lowp float tmpvar_53;
  mediump vec4 shadows_54;
  highp vec4 shadowVals_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_57;
  P_57 = (tmpvar_56.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_58;
  tmpvar_58 = texture2D (_ShadowMapTexture, P_57).x;
  shadowVals_55.x = tmpvar_58;
  highp vec2 P_59;
  P_59 = (tmpvar_56.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_60;
  tmpvar_60 = texture2D (_ShadowMapTexture, P_59).x;
  shadowVals_55.y = tmpvar_60;
  highp vec2 P_61;
  P_61 = (tmpvar_56.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_62;
  tmpvar_62 = texture2D (_ShadowMapTexture, P_61).x;
  shadowVals_55.z = tmpvar_62;
  highp vec2 P_63;
  P_63 = (tmpvar_56.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_64;
  tmpvar_64 = texture2D (_ShadowMapTexture, P_63).x;
  shadowVals_55.w = tmpvar_64;
  bvec4 tmpvar_65;
  tmpvar_65 = lessThan (shadowVals_55, tmpvar_56.zzzz);
  highp vec4 tmpvar_66;
  tmpvar_66 = _LightShadowData.xxxx;
  highp float tmpvar_67;
  if (tmpvar_65.x) {
    tmpvar_67 = tmpvar_66.x;
  } else {
    tmpvar_67 = 1.0;
  };
  highp float tmpvar_68;
  if (tmpvar_65.y) {
    tmpvar_68 = tmpvar_66.y;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_65.z) {
    tmpvar_69 = tmpvar_66.z;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_65.w) {
    tmpvar_70 = tmpvar_66.w;
  } else {
    tmpvar_70 = 1.0;
  };
  highp vec4 tmpvar_71;
  tmpvar_71.x = tmpvar_67;
  tmpvar_71.y = tmpvar_68;
  tmpvar_71.z = tmpvar_69;
  tmpvar_71.w = tmpvar_70;
  shadows_54 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (shadows_54, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_53 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_49.w) * tmpvar_52.w) * tmpvar_53);
  atten_4 = tmpvar_73;
  mediump float tmpvar_74;
  tmpvar_74 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_75;
  tmpvar_75 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_74)), 0.0, 1.0);
  light_3 = tmpvar_75;
  mediump vec3 tmpvar_76;
  tmpvar_76 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_76;
  mediump vec3 tmpvar_77;
  mediump vec3 i_78;
  i_78 = -(lightDirection_6);
  tmpvar_77 = (i_78 - (2.0 * (dot (normalDir_5, i_78) * normalDir_5)));
  highp vec3 tmpvar_79;
  tmpvar_79 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_77, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = (light_3 + (tex_10.w * tmpvar_79));
  light_3 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_81);
  highp vec3 tmpvar_82;
  tmpvar_82 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_82);
  highp vec3 tmpvar_83;
  tmpvar_83 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_83;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  tmpvar_49 = texture2D (_LightTexture0, P_50);
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52 = texture2D (_LightTextureB0, vec2(tmpvar_51));
  lowp float tmpvar_53;
  mediump vec4 shadows_54;
  highp vec4 shadowVals_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec2 P_57;
  P_57 = (tmpvar_56.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_58;
  tmpvar_58 = texture2D (_ShadowMapTexture, P_57).x;
  shadowVals_55.x = tmpvar_58;
  highp vec2 P_59;
  P_59 = (tmpvar_56.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_60;
  tmpvar_60 = texture2D (_ShadowMapTexture, P_59).x;
  shadowVals_55.y = tmpvar_60;
  highp vec2 P_61;
  P_61 = (tmpvar_56.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_62;
  tmpvar_62 = texture2D (_ShadowMapTexture, P_61).x;
  shadowVals_55.z = tmpvar_62;
  highp vec2 P_63;
  P_63 = (tmpvar_56.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_64;
  tmpvar_64 = texture2D (_ShadowMapTexture, P_63).x;
  shadowVals_55.w = tmpvar_64;
  bvec4 tmpvar_65;
  tmpvar_65 = lessThan (shadowVals_55, tmpvar_56.zzzz);
  highp vec4 tmpvar_66;
  tmpvar_66 = _LightShadowData.xxxx;
  highp float tmpvar_67;
  if (tmpvar_65.x) {
    tmpvar_67 = tmpvar_66.x;
  } else {
    tmpvar_67 = 1.0;
  };
  highp float tmpvar_68;
  if (tmpvar_65.y) {
    tmpvar_68 = tmpvar_66.y;
  } else {
    tmpvar_68 = 1.0;
  };
  highp float tmpvar_69;
  if (tmpvar_65.z) {
    tmpvar_69 = tmpvar_66.z;
  } else {
    tmpvar_69 = 1.0;
  };
  highp float tmpvar_70;
  if (tmpvar_65.w) {
    tmpvar_70 = tmpvar_66.w;
  } else {
    tmpvar_70 = 1.0;
  };
  highp vec4 tmpvar_71;
  tmpvar_71.x = tmpvar_67;
  tmpvar_71.y = tmpvar_68;
  tmpvar_71.z = tmpvar_69;
  tmpvar_71.w = tmpvar_70;
  shadows_54 = tmpvar_71;
  mediump float tmpvar_72;
  tmpvar_72 = dot (shadows_54, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_53 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_49.w) * tmpvar_52.w) * tmpvar_53);
  atten_4 = tmpvar_73;
  mediump float tmpvar_74;
  tmpvar_74 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_75;
  tmpvar_75 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_74)), 0.0, 1.0);
  light_3 = tmpvar_75;
  mediump vec3 tmpvar_76;
  tmpvar_76 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_76;
  mediump vec3 tmpvar_77;
  mediump vec3 i_78;
  i_78 = -(lightDirection_6);
  tmpvar_77 = (i_78 - (2.0 * (dot (normalDir_5, i_78) * normalDir_5)));
  highp vec3 tmpvar_79;
  tmpvar_79 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_77, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_79;
  highp vec3 tmpvar_80;
  tmpvar_80 = (light_3 + (tex_10.w * tmpvar_79));
  light_3 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_81);
  highp vec3 tmpvar_82;
  tmpvar_82 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_82);
  highp vec3 tmpvar_83;
  tmpvar_83 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_83;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 411
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 508
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 500
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 402
uniform sampler2D _LightTextureB0;
#line 407
#line 421
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 434
#line 442
#line 456
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 489
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 493
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 497
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 519
#line 519
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 523
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 527
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 532
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 411
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 508
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 500
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 402
uniform sampler2D _LightTextureB0;
#line 407
#line 421
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 434
#line 442
#line 456
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 489
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 493
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 497
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 519
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 407
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 403
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 388
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 390
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 394
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 398
    return shadow;
}
#line 534
lowp vec4 frag( in v2f IN ) {
    #line 536
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 540
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 544
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 548
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 552
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 556
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 560
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform mat4 unity_World2Shadow[4];
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * gl_Vertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2.xyz = tmpvar_24.xyz;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  vec4 shadows_27;
  vec3 tmpvar_28;
  tmpvar_28 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  shadows_27.x = shadow2D (_ShadowMapTexture, (tmpvar_28 + _ShadowOffsets[0].xyz)).x;
  shadows_27.y = shadow2D (_ShadowMapTexture, (tmpvar_28 + _ShadowOffsets[1].xyz)).x;
  shadows_27.z = shadow2D (_ShadowMapTexture, (tmpvar_28 + _ShadowOffsets[2].xyz)).x;
  shadows_27.w = shadow2D (_ShadowMapTexture, (tmpvar_28 + _ShadowOffsets[3].xyz)).x;
  vec4 tmpvar_29;
  tmpvar_29 = (_LightShadowData.xxxx + (shadows_27 * (1.0 - _LightShadowData.xxxx)));
  shadows_27 = tmpvar_29;
  float tmpvar_30;
  tmpvar_30 = (((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz))).w) * dot (tmpvar_29, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_31;
  i_31 = -(tmpvar_25.xyz);
  vec3 tmpvar_32;
  tmpvar_32 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * ((tmpvar_26 - 0.01) / 0.99)) * 4.0) * tmpvar_30), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_30 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_31 - (2.0 * (dot (xlv_TEXCOORD2, i_31) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_32) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_32));
  color_2.xyz = (color_2.xyz * tmpvar_32);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [_Object2World]
Matrix 12 [_LightMatrix0]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c17.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c16
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c11
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
dp4 o5.w, r0, c7
dp4 o5.z, r0, c6
dp4 o5.y, r0, c5
dp4 o5.x, r0, c4
rcp o1.x, r1.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9.xyz = tmpvar_44.xyz;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
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
  highp vec3 tmpvar_54;
  tmpvar_54 = (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w);
  highp vec3 coord_55;
  coord_55 = (tmpvar_54 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_56;
  tmpvar_56 = shadow2DEXT (_ShadowMapTexture, coord_55);
  shadows_53.x = tmpvar_56;
  highp vec3 coord_57;
  coord_57 = (tmpvar_54 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_58;
  tmpvar_58 = shadow2DEXT (_ShadowMapTexture, coord_57);
  shadows_53.y = tmpvar_58;
  highp vec3 coord_59;
  coord_59 = (tmpvar_54 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_60;
  tmpvar_60 = shadow2DEXT (_ShadowMapTexture, coord_59);
  shadows_53.z = tmpvar_60;
  highp vec3 coord_61;
  coord_61 = (tmpvar_54 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_62;
  tmpvar_62 = shadow2DEXT (_ShadowMapTexture, coord_61);
  shadows_53.w = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (_LightShadowData.xxxx + (shadows_53 * (1.0 - _LightShadowData.xxxx)));
  shadows_53 = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = dot (shadows_53, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_52 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = (((float((xlv_TEXCOORD3.z > 0.0)) * tmpvar_48.w) * tmpvar_51.w) * tmpvar_52);
  atten_4 = tmpvar_65;
  mediump float tmpvar_66;
  tmpvar_66 = clamp ((((_LightColor0.w * ((tmpvar_47 - 0.01) / 0.99)) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_67;
  tmpvar_67 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_66)), 0.0, 1.0);
  light_3 = tmpvar_67;
  mediump vec3 tmpvar_68;
  tmpvar_68 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_68;
  mediump vec3 tmpvar_69;
  mediump vec3 i_70;
  i_70 = -(lightDirection_6);
  tmpvar_69 = (i_70 - (2.0 * (dot (normalDir_5, i_70) * normalDir_5)));
  highp vec3 tmpvar_71;
  tmpvar_71 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_69, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = (light_3 + (tex_10.w * tmpvar_71));
  light_3 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_73);
  highp vec3 tmpvar_74;
  tmpvar_74 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_74);
  highp vec3 tmpvar_75;
  tmpvar_75 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_75;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 411
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 508
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 500
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 402
uniform sampler2D _LightTextureB0;
#line 407
#line 421
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 434
#line 442
#line 456
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 489
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 493
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 497
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 519
#line 519
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 523
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 527
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 532
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 411
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 508
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec4 _LightCoord;
    highp vec4 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 500
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 402
uniform sampler2D _LightTextureB0;
#line 407
#line 421
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 434
#line 442
#line 456
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 489
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 493
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 497
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 519
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 407
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 403
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 388
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 390
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 394
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 398
    return shadow;
}
#line 534
lowp vec4 frag( in v2f IN ) {
    #line 536
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 540
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 544
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 548
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * unitySampleShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 552
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 556
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 560
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 shadowVals_29;
  shadowVals_29.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_29.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_29.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_29.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_30;
  tmpvar_30 = lessThan (shadowVals_29, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_31;
  tmpvar_31 = _LightShadowData.xxxx;
  float tmpvar_32;
  if (tmpvar_30.x) {
    tmpvar_32 = tmpvar_31.x;
  } else {
    tmpvar_32 = 1.0;
  };
  float tmpvar_33;
  if (tmpvar_30.y) {
    tmpvar_33 = tmpvar_31.y;
  } else {
    tmpvar_33 = 1.0;
  };
  float tmpvar_34;
  if (tmpvar_30.z) {
    tmpvar_34 = tmpvar_31.z;
  } else {
    tmpvar_34 = 1.0;
  };
  float tmpvar_35;
  if (tmpvar_30.w) {
    tmpvar_35 = tmpvar_31.w;
  } else {
    tmpvar_35 = 1.0;
  };
  vec4 tmpvar_36;
  tmpvar_36.x = tmpvar_32;
  tmpvar_36.y = tmpvar_33;
  tmpvar_36.z = tmpvar_34;
  tmpvar_36.w = tmpvar_35;
  float tmpvar_37;
  tmpvar_37 = (tmpvar_28.w * dot (tmpvar_36, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_38;
  i_38 = -(tmpvar_25.xyz);
  vec3 tmpvar_39;
  tmpvar_39 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_37), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_37 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_38 - (2.0 * (dot (xlv_TEXCOORD2, i_38) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_39) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_39));
  color_2.xyz = (color_2.xyz * tmpvar_39);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c14.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
add o5.xyz, r0, -c13
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTexture0, vec2(tmpvar_49));
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
  tmpvar_75 = (tmpvar_50.w * tmpvar_51);
  atten_4 = tmpvar_75;
  mediump float tmpvar_76;
  tmpvar_76 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_77;
  tmpvar_77 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_76)), 0.0, 1.0);
  light_3 = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_78;
  mediump vec3 tmpvar_79;
  mediump vec3 i_80;
  i_80 = -(lightDirection_6);
  tmpvar_79 = (i_80 - (2.0 * (dot (normalDir_5, i_80) * normalDir_5)));
  highp vec3 tmpvar_81;
  tmpvar_81 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_79, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = (light_3 + (tex_10.w * tmpvar_81));
  light_3 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_83);
  highp vec3 tmpvar_84;
  tmpvar_84 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_84);
  highp vec3 tmpvar_85;
  tmpvar_85 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_85;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTexture0, vec2(tmpvar_49));
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
  tmpvar_75 = (tmpvar_50.w * tmpvar_51);
  atten_4 = tmpvar_75;
  mediump float tmpvar_76;
  tmpvar_76 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_77;
  tmpvar_77 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_76)), 0.0, 1.0);
  light_3 = tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_78;
  mediump vec3 tmpvar_79;
  mediump vec3 i_80;
  i_80 = -(lightDirection_6);
  tmpvar_79 = (i_80 - (2.0 * (dot (normalDir_5, i_80) * normalDir_5)));
  highp vec3 tmpvar_81;
  tmpvar_81 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_79, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = (light_3 + (tex_10.w * tmpvar_81));
  light_3 = tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_83);
  highp vec3 tmpvar_84;
  tmpvar_84 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_84);
  highp vec3 tmpvar_85;
  tmpvar_85 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_85;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 407
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 504
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 496
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 406
uniform highp mat4 _LightMatrix0;
#line 417
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 430
#line 438
#line 452
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 485
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 489
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 493
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 515
#line 515
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 519
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 523
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 528
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 407
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 504
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 496
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTexture0;
#line 406
uniform highp mat4 _LightMatrix0;
#line 417
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 430
#line 438
#line 452
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 485
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 489
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 493
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 515
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 387
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 390
    return DecodeFloatRGBA( packDist);
}
#line 392
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 394
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 398
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 402
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 530
lowp vec4 frag( in v2f IN ) {
    #line 532
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 536
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 540
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 544
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 548
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 552
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 556
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform mat4 _LightMatrix0;
uniform mat4 _Object2World;

uniform vec4 _LightPositionRange;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 p_1;
  p_1 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = gl_Normal;
  vec4 tmpvar_3;
  tmpvar_3.x = gl_MultiTexCoord0.x;
  tmpvar_3.y = gl_MultiTexCoord0.y;
  tmpvar_3.z = gl_MultiTexCoord1.x;
  tmpvar_3.w = gl_MultiTexCoord1.y;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * gl_Vertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * gl_Vertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform float _Reflectivity;
uniform float _LightPower;
uniform float _MinLight;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform float _MainTexHandoverDist;
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
void main ()
{
  vec4 main_1;
  vec4 color_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD5);
  vec2 uv_4;
  float r_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float y_over_x_6;
    y_over_x_6 = (tmpvar_3.x / tmpvar_3.z);
    float s_7;
    float x_8;
    x_8 = (y_over_x_6 * inversesqrt(((y_over_x_6 * y_over_x_6) + 1.0)));
    s_7 = (sign(x_8) * (1.5708 - (sqrt((1.0 - abs(x_8))) * (1.5708 + (abs(x_8) * (-0.214602 + (abs(x_8) * (0.0865667 + (abs(x_8) * -0.0310296)))))))));
    r_5 = s_7;
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        r_5 = (s_7 + 3.14159);
      } else {
        r_5 = (r_5 - 3.14159);
      };
    };
  } else {
    r_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * r_5));
  uv_4.y = (0.31831 * (1.5708 - (sign(tmpvar_3.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_3.y))) * (1.5708 + (abs(tmpvar_3.y) * (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (abs(tmpvar_3.y) * -0.0310296)))))))))));
  vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_4.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_4.y);
  main_1 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD5);
  vec2 uv_13;
  float r_14;
  if ((abs(tmpvar_12.z) > (1e-08 * abs(tmpvar_12.x)))) {
    float y_over_x_15;
    y_over_x_15 = (tmpvar_12.x / tmpvar_12.z);
    float s_16;
    float x_17;
    x_17 = (y_over_x_15 * inversesqrt(((y_over_x_15 * y_over_x_15) + 1.0)));
    s_16 = (sign(x_17) * (1.5708 - (sqrt((1.0 - abs(x_17))) * (1.5708 + (abs(x_17) * (-0.214602 + (abs(x_17) * (0.0865667 + (abs(x_17) * -0.0310296)))))))));
    r_14 = s_16;
    if ((tmpvar_12.z < 0.0)) {
      if ((tmpvar_12.x >= 0.0)) {
        r_14 = (s_16 + 3.14159);
      } else {
        r_14 = (r_14 - 3.14159);
      };
    };
  } else {
    r_14 = (sign(tmpvar_12.x) * 1.5708);
  };
  uv_13.x = (0.5 + (0.159155 * r_14));
  uv_13.y = (0.31831 * (1.5708 - (sign(tmpvar_12.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_12.y))) * (1.5708 + (abs(tmpvar_12.y) * (-0.214602 + (abs(tmpvar_12.y) * (0.0865667 + (abs(tmpvar_12.y) * -0.0310296)))))))))));
  vec2 tmpvar_18;
  tmpvar_18 = dFdx(tmpvar_12.xz);
  vec2 tmpvar_19;
  tmpvar_19 = dFdy(tmpvar_12.xz);
  vec4 tmpvar_20;
  tmpvar_20.x = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_20.y = dFdx(uv_13.y);
  tmpvar_20.z = (0.159155 * sqrt(dot (tmpvar_19, tmpvar_19)));
  tmpvar_20.w = dFdy(uv_13.y);
  vec3 tmpvar_21;
  tmpvar_21 = abs(tmpvar_12);
  float tmpvar_22;
  tmpvar_22 = float((tmpvar_21.z >= tmpvar_21.x));
  vec3 tmpvar_23;
  tmpvar_23 = mix (tmpvar_21.yxz, mix (tmpvar_21, tmpvar_21.zxy, vec3(tmpvar_22)), vec3(float((mix (tmpvar_21.x, tmpvar_21.z, tmpvar_22) >= tmpvar_21.y))));
  vec4 tmpvar_24;
  tmpvar_24 = (mix (mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_23.zy) / abs(tmpvar_23.x)) * _DetailScale), tmpvar_20.xy, tmpvar_20.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0))), main_1, vec4(clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0))) * _Color);
  color_2 = tmpvar_24;
  vec4 tmpvar_25;
  tmpvar_25 = normalize(_WorldSpaceLightPos0);
  float tmpvar_26;
  tmpvar_26 = clamp (dot (xlv_TEXCOORD2, tmpvar_25.xyz), 0.0, 1.0);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_26 - 0.01) / 0.99);
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3)));
  vec4 tmpvar_29;
  tmpvar_29 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  vec4 shadowVals_30;
  shadowVals_30.x = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_30.y = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_30.z = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  shadowVals_30.w = dot (textureCube (_ShadowMapTexture, (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125))), vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_31;
  tmpvar_31 = lessThan (shadowVals_30, vec4(((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97)));
  vec4 tmpvar_32;
  tmpvar_32 = _LightShadowData.xxxx;
  float tmpvar_33;
  if (tmpvar_31.x) {
    tmpvar_33 = tmpvar_32.x;
  } else {
    tmpvar_33 = 1.0;
  };
  float tmpvar_34;
  if (tmpvar_31.y) {
    tmpvar_34 = tmpvar_32.y;
  } else {
    tmpvar_34 = 1.0;
  };
  float tmpvar_35;
  if (tmpvar_31.z) {
    tmpvar_35 = tmpvar_32.z;
  } else {
    tmpvar_35 = 1.0;
  };
  float tmpvar_36;
  if (tmpvar_31.w) {
    tmpvar_36 = tmpvar_32.w;
  } else {
    tmpvar_36 = 1.0;
  };
  vec4 tmpvar_37;
  tmpvar_37.x = tmpvar_33;
  tmpvar_37.y = tmpvar_34;
  tmpvar_37.z = tmpvar_35;
  tmpvar_37.w = tmpvar_36;
  float tmpvar_38;
  tmpvar_38 = ((tmpvar_28.w * tmpvar_29.w) * dot (tmpvar_37, vec4(0.25, 0.25, 0.25, 0.25)));
  vec3 i_39;
  i_39 = -(tmpvar_25.xyz);
  vec3 tmpvar_40;
  tmpvar_40 = (clamp ((gl_LightModel.ambient.xyz + ((_MinLight + _LightColor0.xyz) * clamp ((((_LightColor0.w * tmpvar_27) * 4.0) * tmpvar_38), 0.0, 1.0))), 0.0, 1.0) + (main_1.w * (vec3(clamp (floor((1.0 + tmpvar_26)), 0.0, 1.0)) * (((tmpvar_38 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot ((i_39 - (2.0 * (dot (xlv_TEXCOORD2, i_39) * xlv_TEXCOORD2))), xlv_TEXCOORD1), 0.0, 1.0), _Shininess)))));
  color_2.w = mix (0.4489, main_1.w, clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0));
  color_2.xyz = (tmpvar_24.xyz * clamp (((_LightPower * tmpvar_40) - color_2.w), 0.0, 1.0));
  color_2.xyz = (color_2.xyz + (_Reflectivity * tmpvar_40));
  color_2.xyz = (color_2.xyz * tmpvar_40);
  gl_FragData[0] = color_2;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_LightPositionRange]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, v1
mov r1.w, c14.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o3.xyz, r0.w, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov r2.zw, v3.xyxy
mov r2.xy, v2
dp4 r1.x, r2, r2
rsq r0.w, r1.x
mul r2.xyz, r0.w, r2
add r1.xyz, -r0, c12
dp3 r0.w, r1, r1
rsq r1.w, r0.w
dp4 r0.w, v0, c7
mov o6.xyz, -r2
mul o2.xyz, r1.w, r1
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rcp o1.x, r1.w
add o5.xyz, r0, -c13
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTextureB0, vec2(tmpvar_49));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_52;
  mediump vec4 shadows_53;
  highp vec4 shadowVals_54;
  highp float tmpvar_55;
  tmpvar_55 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_56;
  vec_56 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_57;
  lowp vec4 tmpvar_58;
  tmpvar_58 = textureCube (_ShadowMapTexture, vec_56);
  packDist_57 = tmpvar_58;
  shadowVals_54.x = dot (packDist_57, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_59;
  vec_59 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_60;
  lowp vec4 tmpvar_61;
  tmpvar_61 = textureCube (_ShadowMapTexture, vec_59);
  packDist_60 = tmpvar_61;
  shadowVals_54.y = dot (packDist_60, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_62;
  vec_62 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_63;
  lowp vec4 tmpvar_64;
  tmpvar_64 = textureCube (_ShadowMapTexture, vec_62);
  packDist_63 = tmpvar_64;
  shadowVals_54.z = dot (packDist_63, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_65;
  vec_65 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_66;
  lowp vec4 tmpvar_67;
  tmpvar_67 = textureCube (_ShadowMapTexture, vec_65);
  packDist_66 = tmpvar_67;
  shadowVals_54.w = dot (packDist_66, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_68;
  tmpvar_68 = lessThan (shadowVals_54, vec4(tmpvar_55));
  highp vec4 tmpvar_69;
  tmpvar_69 = _LightShadowData.xxxx;
  highp float tmpvar_70;
  if (tmpvar_68.x) {
    tmpvar_70 = tmpvar_69.x;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_68.y) {
    tmpvar_71 = tmpvar_69.y;
  } else {
    tmpvar_71 = 1.0;
  };
  highp float tmpvar_72;
  if (tmpvar_68.z) {
    tmpvar_72 = tmpvar_69.z;
  } else {
    tmpvar_72 = 1.0;
  };
  highp float tmpvar_73;
  if (tmpvar_68.w) {
    tmpvar_73 = tmpvar_69.w;
  } else {
    tmpvar_73 = 1.0;
  };
  highp vec4 tmpvar_74;
  tmpvar_74.x = tmpvar_70;
  tmpvar_74.y = tmpvar_71;
  tmpvar_74.z = tmpvar_72;
  tmpvar_74.w = tmpvar_73;
  shadows_53 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = dot (shadows_53, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_52 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = ((tmpvar_50.w * tmpvar_51.w) * tmpvar_52);
  atten_4 = tmpvar_76;
  mediump float tmpvar_77;
  tmpvar_77 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_78;
  tmpvar_78 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_77)), 0.0, 1.0);
  light_3 = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_79;
  mediump vec3 tmpvar_80;
  mediump vec3 i_81;
  i_81 = -(lightDirection_6);
  tmpvar_80 = (i_81 - (2.0 * (dot (normalDir_5, i_81) * normalDir_5)));
  highp vec3 tmpvar_82;
  tmpvar_82 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_80, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = (light_3 + (tex_10.w * tmpvar_82));
  light_3 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_84);
  highp vec3 tmpvar_85;
  tmpvar_85 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_85);
  highp vec3 tmpvar_86;
  tmpvar_86 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_86;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _LightPositionRange;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 p_1;
  p_1 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.x = _glesMultiTexCoord0.x;
  tmpvar_3.y = _glesMultiTexCoord0.y;
  tmpvar_3.z = _glesMultiTexCoord1.x;
  tmpvar_3.w = _glesMultiTexCoord1.y;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = sqrt(dot (p_1, p_1));
  xlv_TEXCOORD1 = normalize((_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz));
  xlv_TEXCOORD2 = normalize((_Object2World * tmpvar_2).xyz);
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
  xlv_TEXCOORD4 = ((_Object2World * _glesVertex).xyz - _LightPositionRange.xyz);
  xlv_TEXCOORD5 = -(normalize(tmpvar_3).xyz);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp float _Reflectivity;
uniform highp float _LightPower;
uniform highp float _MinLight;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform highp float _MainTexHandoverDist;
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
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 specularReflection_2;
  mediump vec3 light_3;
  lowp float atten_4;
  mediump vec3 normalDir_5;
  mediump vec3 lightDirection_6;
  mediump vec3 ambientLighting_7;
  mediump float detailLevel_8;
  mediump vec4 color_9;
  mediump vec4 tex_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_12;
  highp float r_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    highp float y_over_x_14;
    y_over_x_14 = (tmpvar_11.x / tmpvar_11.z);
    highp float s_15;
    highp float x_16;
    x_16 = (y_over_x_14 * inversesqrt(((y_over_x_14 * y_over_x_14) + 1.0)));
    s_15 = (sign(x_16) * (1.5708 - (sqrt((1.0 - abs(x_16))) * (1.5708 + (abs(x_16) * (-0.214602 + (abs(x_16) * (0.0865667 + (abs(x_16) * -0.0310296)))))))));
    r_13 = s_15;
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        r_13 = (s_15 + 3.14159);
      } else {
        r_13 = (r_13 - 3.14159);
      };
    };
  } else {
    r_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * r_13));
  uv_12.y = (0.31831 * (1.5708 - (sign(tmpvar_11.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_11.y))) * (1.5708 + (abs(tmpvar_11.y) * (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (abs(tmpvar_11.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_17;
  tmpvar_17 = dFdx(tmpvar_11.xz);
  highp vec2 tmpvar_18;
  tmpvar_18 = dFdy(tmpvar_11.xz);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_19.y = dFdx(uv_12.y);
  tmpvar_19.z = (0.159155 * sqrt(dot (tmpvar_18, tmpvar_18)));
  tmpvar_19.w = dFdy(uv_12.y);
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DGradEXT (_MainTex, uv_12, tmpvar_19.xy, tmpvar_19.zw);
  tex_10 = tmpvar_20;
  mediump vec4 tmpvar_21;
  mediump vec3 detailCoords_22;
  mediump float nylerp_23;
  mediump float zxlerp_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(xlv_TEXCOORD5);
  highp vec2 uv_26;
  highp float r_27;
  if ((abs(tmpvar_25.z) > (1e-08 * abs(tmpvar_25.x)))) {
    highp float y_over_x_28;
    y_over_x_28 = (tmpvar_25.x / tmpvar_25.z);
    highp float s_29;
    highp float x_30;
    x_30 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    s_29 = (sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296)))))))));
    r_27 = s_29;
    if ((tmpvar_25.z < 0.0)) {
      if ((tmpvar_25.x >= 0.0)) {
        r_27 = (s_29 + 3.14159);
      } else {
        r_27 = (r_27 - 3.14159);
      };
    };
  } else {
    r_27 = (sign(tmpvar_25.x) * 1.5708);
  };
  uv_26.x = (0.5 + (0.159155 * r_27));
  uv_26.y = (0.31831 * (1.5708 - (sign(tmpvar_25.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_25.y))) * (1.5708 + (abs(tmpvar_25.y) * (-0.214602 + (abs(tmpvar_25.y) * (0.0865667 + (abs(tmpvar_25.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_31;
  tmpvar_31 = dFdx(tmpvar_25.xz);
  highp vec2 tmpvar_32;
  tmpvar_32 = dFdy(tmpvar_25.xz);
  highp vec4 tmpvar_33;
  tmpvar_33.x = (0.159155 * sqrt(dot (tmpvar_31, tmpvar_31)));
  tmpvar_33.y = dFdx(uv_26.y);
  tmpvar_33.z = (0.159155 * sqrt(dot (tmpvar_32, tmpvar_32)));
  tmpvar_33.w = dFdy(uv_26.y);
  highp vec3 tmpvar_34;
  tmpvar_34 = abs(tmpvar_25);
  highp float tmpvar_35;
  tmpvar_35 = float((tmpvar_34.z >= tmpvar_34.x));
  zxlerp_24 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = float((mix (tmpvar_34.x, tmpvar_34.z, zxlerp_24) >= tmpvar_34.y));
  nylerp_23 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = mix (tmpvar_34, tmpvar_34.zxy, vec3(zxlerp_24));
  detailCoords_22 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = mix (tmpvar_34.yxz, detailCoords_22, vec3(nylerp_23));
  detailCoords_22 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = abs(detailCoords_22.x);
  highp vec2 coord_40;
  coord_40 = (((0.5 * detailCoords_22.zy) / tmpvar_39) * _DetailScale);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DGradEXT (_DetailTex, coord_40, tmpvar_33.xy, tmpvar_33.zw);
  tmpvar_21 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * xlv_TEXCOORD0), 0.0, 1.0);
  detailLevel_8 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  mediump vec4 tmpvar_44;
  tmpvar_44 = (mix (mix (tmpvar_21, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_8)), tex_10, vec4(tmpvar_43)) * _Color);
  color_9 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = glstate_lightmodel_ambient.xyz;
  ambientLighting_7 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = normalize(_WorldSpaceLightPos0).xyz;
  lightDirection_6 = tmpvar_46;
  normalDir_5 = xlv_TEXCOORD2;
  mediump float tmpvar_47;
  tmpvar_47 = clamp (dot (normalDir_5, lightDirection_6), 0.0, 1.0);
  mediump float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 - 0.01) / 0.99);
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_LightTextureB0, vec2(tmpvar_49));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_LightTexture0, xlv_TEXCOORD3);
  highp float tmpvar_52;
  mediump vec4 shadows_53;
  highp vec4 shadowVals_54;
  highp float tmpvar_55;
  tmpvar_55 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * _LightPositionRange.w) * 0.97);
  highp vec3 vec_56;
  vec_56 = (xlv_TEXCOORD4 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_57;
  lowp vec4 tmpvar_58;
  tmpvar_58 = textureCube (_ShadowMapTexture, vec_56);
  packDist_57 = tmpvar_58;
  shadowVals_54.x = dot (packDist_57, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_59;
  vec_59 = (xlv_TEXCOORD4 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_60;
  lowp vec4 tmpvar_61;
  tmpvar_61 = textureCube (_ShadowMapTexture, vec_59);
  packDist_60 = tmpvar_61;
  shadowVals_54.y = dot (packDist_60, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_62;
  vec_62 = (xlv_TEXCOORD4 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_63;
  lowp vec4 tmpvar_64;
  tmpvar_64 = textureCube (_ShadowMapTexture, vec_62);
  packDist_63 = tmpvar_64;
  shadowVals_54.z = dot (packDist_63, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_65;
  vec_65 = (xlv_TEXCOORD4 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_66;
  lowp vec4 tmpvar_67;
  tmpvar_67 = textureCube (_ShadowMapTexture, vec_65);
  packDist_66 = tmpvar_67;
  shadowVals_54.w = dot (packDist_66, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_68;
  tmpvar_68 = lessThan (shadowVals_54, vec4(tmpvar_55));
  highp vec4 tmpvar_69;
  tmpvar_69 = _LightShadowData.xxxx;
  highp float tmpvar_70;
  if (tmpvar_68.x) {
    tmpvar_70 = tmpvar_69.x;
  } else {
    tmpvar_70 = 1.0;
  };
  highp float tmpvar_71;
  if (tmpvar_68.y) {
    tmpvar_71 = tmpvar_69.y;
  } else {
    tmpvar_71 = 1.0;
  };
  highp float tmpvar_72;
  if (tmpvar_68.z) {
    tmpvar_72 = tmpvar_69.z;
  } else {
    tmpvar_72 = 1.0;
  };
  highp float tmpvar_73;
  if (tmpvar_68.w) {
    tmpvar_73 = tmpvar_69.w;
  } else {
    tmpvar_73 = 1.0;
  };
  highp vec4 tmpvar_74;
  tmpvar_74.x = tmpvar_70;
  tmpvar_74.y = tmpvar_71;
  tmpvar_74.z = tmpvar_72;
  tmpvar_74.w = tmpvar_73;
  shadows_53 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = dot (shadows_53, vec4(0.25, 0.25, 0.25, 0.25));
  tmpvar_52 = tmpvar_75;
  highp float tmpvar_76;
  tmpvar_76 = ((tmpvar_50.w * tmpvar_51.w) * tmpvar_52);
  atten_4 = tmpvar_76;
  mediump float tmpvar_77;
  tmpvar_77 = clamp ((((_LightColor0.w * tmpvar_48) * 4.0) * atten_4), 0.0, 1.0);
  highp vec3 tmpvar_78;
  tmpvar_78 = clamp ((ambientLighting_7 + ((_MinLight + _LightColor0.xyz) * tmpvar_77)), 0.0, 1.0);
  light_3 = tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79 = vec3(clamp (floor((1.0 + tmpvar_47)), 0.0, 1.0));
  specularReflection_2 = tmpvar_79;
  mediump vec3 tmpvar_80;
  mediump vec3 i_81;
  i_81 = -(lightDirection_6);
  tmpvar_80 = (i_81 - (2.0 * (dot (normalDir_5, i_81) * normalDir_5)));
  highp vec3 tmpvar_82;
  tmpvar_82 = (specularReflection_2 * (((atten_4 * _LightColor0.xyz) * _SpecColor.xyz) * pow (clamp (dot (tmpvar_80, xlv_TEXCOORD1), 0.0, 1.0), _Shininess)));
  specularReflection_2 = tmpvar_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = (light_3 + (tex_10.w * tmpvar_82));
  light_3 = tmpvar_83;
  highp float tmpvar_84;
  tmpvar_84 = clamp (pow ((_MainTexHandoverDist * xlv_TEXCOORD0), 3.0), 0.0, 1.0);
  color_9.w = mix (0.4489, tex_10.w, tmpvar_84);
  highp vec3 tmpvar_85;
  tmpvar_85 = clamp (((_LightPower * light_3) - color_9.w), 0.0, 1.0);
  color_9.xyz = (tmpvar_44.xyz * tmpvar_85);
  highp vec3 tmpvar_86;
  tmpvar_86 = (color_9.xyz + (_Reflectivity * light_3));
  color_9.xyz = tmpvar_86;
  color_9.xyz = (color_9.xyz * light_3);
  tmpvar_1 = color_9;
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
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 408
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 497
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 406
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 418
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 431
#line 439
#line 453
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 486
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 490
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 494
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 516
#line 516
v2f vert( in appdata_t v ) {
    v2f o;
    highp vec4 vertex = v.vertex;
    #line 520
    o.pos = (glstate_matrix_mvp * vertex).xyzw;
    highp vec3 vertexPos = (_Object2World * vertex).xyz;
    o.viewDist = distance( vertexPos, _WorldSpaceCameraPos);
    o.worldNormal = normalize((_Object2World * vec4( v.normal, 0.0)).xyz);
    #line 524
    o.sphereNormal = (-normalize(vec4( v.texcoord.x, v.texcoord.y, v.texcoord2.x, v.texcoord2.y)).xyz);
    o.viewDir = normalize((_WorldSpaceCameraPos.xyz - (_Object2World * vertex).xyz));
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    o._ShadowCoord = ((_Object2World * v.vertex).xyz - _LightPositionRange.xyz);
    #line 529
    return o;
}
out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord2 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.viewDist);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.worldNormal);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
    xlv_TEXCOORD4 = vec3(xl_retval._ShadowCoord);
    xlv_TEXCOORD5 = vec3(xl_retval.sphereNormal);
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
#line 408
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp float viewDist;
    highp vec3 viewDir;
    highp vec3 worldNormal;
    highp vec3 _LightCoord;
    highp vec3 _ShadowCoord;
    highp vec3 sphereNormal;
};
#line 497
struct appdata_t {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord2;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
#line 406
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
#line 418
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 431
#line 439
#line 453
uniform lowp vec4 _Color;
uniform highp float _Shininess;
#line 486
uniform sampler2D _MainTex;
uniform highp float _MainTexHandoverDist;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
#line 490
uniform highp float _DetailDist;
uniform highp float _MinLight;
uniform highp float _Clarity;
uniform sampler2D _CameraDepthTexture;
#line 494
uniform highp mat4 _CameraToWorld;
uniform highp float _LightPower;
uniform highp float _Reflectivity;
#line 516
#line 321
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 323
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 327
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 330
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 332
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 336
    return uv;
}
#line 368
mediump vec4 GetShereDetailMap( in sampler2D texSampler, in highp vec3 sphereVect, in highp float detailScale ) {
    #line 370
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    sphereVectNorm = abs(sphereVectNorm);
    #line 374
    mediump float zxlerp = step( sphereVectNorm.x, sphereVectNorm.z);
    mediump float nylerp = step( sphereVectNorm.y, mix( sphereVectNorm.x, sphereVectNorm.z, zxlerp));
    mediump vec3 detailCoords = mix( sphereVectNorm.xyz, sphereVectNorm.zxy, vec3( zxlerp));
    detailCoords = mix( sphereVectNorm.yxz, detailCoords, vec3( nylerp));
    #line 378
    return xll_tex2Dgrad( texSampler, (((0.5 * detailCoords.zy) / abs(detailCoords.x)) * detailScale), uvdd.xy, uvdd.zw);
}
#line 347
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 349
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 353
    return tex;
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 387
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 390
    return DecodeFloatRGBA( packDist);
}
#line 392
highp float unityCubeShadow( in highp vec3 vec ) {
    #line 394
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    #line 398
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    #line 402
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 531
lowp vec4 frag( in v2f IN ) {
    #line 533
    mediump vec4 color;
    highp vec3 sphereNrm = IN.sphereNormal;
    mediump vec4 main = GetSphereMap( _MainTex, sphereNrm);
    mediump vec4 detail = GetShereDetailMap( _DetailTex, sphereNrm, _DetailScale);
    #line 537
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * IN.viewDist));
    color = mix( detail.xyzw, vec4( 1.0), vec4( detailLevel));
    color = mix( color, main, vec4( xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0))));
    color *= _Color;
    #line 541
    mediump vec3 ambientLighting = vec3( glstate_lightmodel_ambient);
    mediump vec3 lightDirection = vec3( normalize(_WorldSpaceLightPos0));
    mediump vec3 normalDir = IN.worldNormal;
    mediump float NdotL = xll_saturate_f(dot( normalDir, lightDirection));
    #line 545
    mediump float diff = ((NdotL - 0.01) / 0.99);
    lowp float atten = ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * unityCubeShadow( IN._ShadowCoord));
    mediump float lightIntensity = xll_saturate_f((((_LightColor0.w * diff) * 4.0) * atten));
    mediump vec3 light = xll_saturate_vf3((ambientLighting + ((_MinLight + _LightColor0.xyz) * lightIntensity)));
    #line 549
    highp vec3 specularReflection = vec3( xll_saturate_f(floor((1.0 + NdotL))));
    specularReflection *= (((atten * vec3( _LightColor0)) * vec3( _SpecColor)) * pow( xll_saturate_f(dot( reflect( (-lightDirection), normalDir), IN.viewDir)), _Shininess));
    light += (main.w * specularReflection);
    color.w = 1.0;
    #line 553
    highp float refrac = 0.67;
    color.w *= pow( refrac, 2.0);
    color.w = mix( color.w, main.w, xll_saturate_f(pow( (_MainTexHandoverDist * IN.viewDist), 3.0)));
    color.xyz *= xll_saturate_vf3(((_LightPower * light) - color.w));
    #line 557
    color.xyz += (_Reflectivity * light);
    color.xyz *= light;
    return color;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
in highp vec3 xlv_TEXCOORD5;
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
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 15
//   d3d9 - ALU: 112 to 132, TEX: 6 to 12
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 114 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r3.xyz, r0.x, v4
abs r2.xyz, r3
add r0.w, r2.z, -r2.x
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs_pp r0.x, r0
rcp_pp r0.w, r0.x
abs r2.y, r3.z
mul_pp r0.zw, r0.xyzy, r0.w
max r0.x, r2, r2.y
mul_pp r0.zw, r0, c16.y
rcp r0.y, r0.x
min r0.x, r2, r2.y
mul r0.x, r0, r0.y
mul r1.xy, r0.zwzw, c7.x
abs r0.w, r3.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c14.y, c14
mad r0.z, r0, r0.y, c14.w
add r1.w, -r0, c12.y
mad r1.z, r0.w, c12, c12.w
mad r1.z, r1, r0.w, c13.x
rsq r1.w, r1.w
mad r2.z, r0, r0.y, c15.x
mad r0.w, r1.z, r0, c13.y
rcp r1.w, r1.w
mul r1.z, r0.w, r1.w
cmp r0.w, r3.y, c12.x, c12.y
mul r1.w, r0, r1.z
mad r0.z, -r1.w, c13, r1
mad r1.z, r2, r0.y, c15.y
mad r0.z, r0.w, c13.w, r0
mul r1.w, r0.z, c14.x
mad r0.y, r1.z, r0, c15.z
mul r3.y, r0, r0.x
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r1.z, r2, r2.w
dsy r0.xz, r3
mul r0.xz, r0, r0
add r0.z, r0.x, r0
rsq r0.x, r1.z
rsq r0.z, r0.z
dsx r0.w, r1
dsy r0.y, r1.w
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
texldd r1.xyz, r1, s1, r0.zwzw, r0
add r2.z, -r3.y, c15.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c13
mul r3.y, v0.x, c8.x
cmp r2.w, r3.z, r2, r3
add_pp r2.xyz, -r1, c12.y
mul_sat r3.y, r3, c13.z
mad_pp r2.xyz, r3.y, r2, r1
cmp r1.x, r3, r2.w, -r2.w
mad r3.x, r1, c16, c16.y
mov r3.y, r1.w
texldd r0, r3, s0, r0.zwzw, r0
dp4 r1.y, c1, c1
rsq r1.x, r1.y
mul r1.xyz, r1.x, c1
dp3_pp r1.w, v2, -r1
mul_pp r3.xyz, v2, r1.w
mad_pp r3.xyz, -r3, c13.z, -r1
mul r1.w, v0.x, c6.x
mul r3.w, r1, r1
add_pp r0.xyz, r0, -r2
mul_sat r1.w, r3, r1
mad_pp r0.xyz, r1.w, r0, r2
mul_pp r2.xyz, r0, c4
dp3_pp_sat r2.w, r3, v1
pow_pp r3, r2.w, c5.x
dp3 r0.x, v3, v3
mov_pp r0.z, r3.x
dp3_pp_sat r0.y, v2, r1
add_pp r3.x, r0.y, c12.y
texld r0.x, r0.x, s2
mul r1.xyz, r0.x, c2
mul r1.xyz, r1, c3
add_pp r0.y, r0, c16.z
mul_pp r0.y, r0, c2.w
mul_pp r0.y, r0, r0.x
mul r1.xyz, r1, r0.z
frc_pp r3.y, r3.x
add_pp_sat r0.z, r3.x, -r3.y
mul r1.xyz, r0.z, r1
mul r1.xyz, r0.w, r1
add_pp r2.w, r0, c17.x
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c2, r0.x
mad_sat r0.xyz, r0, r0.w, c0
add_pp r0.xyz, r0, r1
mad_pp r0.w, r1, r2, c17.y
mul r3.xyz, r0, c11.x
mad_sat r1.xyz, r0, c10.x, -r0.w
mad_pp r1.xyz, r2, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 112 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord5 v3.xyz
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul r3.xyz, r0.x, v3
abs r0.xyz, r3
add r0.w, r0.z, -r0.x
dsy r2.zw, r3.xyxz
add r1.xyz, r0.zxyw, -r0
cmp r0.w, r0, c12.y, c12.x
mad r1.xyz, r0.w, r1, r0
add r0.w, -r0.y, r1.x
cmp r1.w, r0, c12.y, c12.x
add r1.xyz, -r0.yxzw, r1
mad r1.xyz, r1.w, r1, r0.yxzw
abs r1.w, r3.y
abs r0.w, r3.z
max r0.y, r0.x, r0.w
rcp r0.z, r0.y
min r0.y, r0.x, r0.w
mul r0.y, r0, r0.z
add r2.y, -r1.w, c12
mad r2.x, r1.w, c12.z, c12.w
mad r2.x, r2, r1.w, c13
abs_pp r1.x, r1
rcp_pp r1.x, r1.x
mul_pp r1.xy, r1.zyzw, r1.x
mul r0.z, r0.y, r0.y
mad r1.z, r0, c14.y, c14
mad r1.z, r1, r0, c14.w
mad r1.z, r1, r0, c15.x
mad r1.z, r1, r0, c15.y
mad r1.z, r1, r0, c15
mul_pp r1.xy, r1, c16.y
rsq r2.y, r2.y
mul r2.zw, r2, r2
mul r1.z, r1, r0.y
add r0.x, r0, -r0.w
mad r1.w, r2.x, r1, c13.y
rcp r2.y, r2.y
mul r2.x, r1.w, r2.y
cmp r1.w, r3.y, c12.x, c12.y
mul r2.y, r1.w, r2.x
mad r0.z, -r2.y, c13, r2.x
mad r0.y, r1.w, c13.w, r0.z
mul r1.w, r0.y, c14.x
add r0.z, -r1, c15.w
cmp r3.y, -r0.x, r1.z, r0.z
add r0.z, r2, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.x, r2, r2.y
rsq r0.z, r0.z
add r2.w, -r3.y, c13
cmp r2.w, r3.z, r3.y, r2
rsq r0.x, r0.x
dsx r0.w, r1
dsy r0.y, r1.w
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
mul r1.xy, r1, c7.x
texldd r1.xyz, r1, s1, r0.zwzw, r0
add_pp r2.xyz, -r1, c12.y
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c8.x
mul_sat r3.x, r3.y, c13.z
mad_pp r1.xyz, r3.x, r2, r1
mad r2.x, r2.w, c16, c16.y
mov r2.y, r1.w
texldd r0, r2, s0, r0.zwzw, r0
dp4_pp r2.z, c1, c1
rsq_pp r1.w, r2.z
mul_pp r2.xyz, r1.w, c1
dp3_pp r2.w, v2, -r2
mul_pp r3.xyz, v2, r2.w
mad_pp r3.xyz, -r3, c13.z, -r2
dp3_pp_sat r2.x, v2, r2
mul r1.w, v0.x, c6.x
add_pp r2.y, r2.x, c12
frc_pp r2.z, r2.y
mul r2.w, r1, r1
dp3_pp_sat r3.x, r3, v1
add_pp r0.xyz, r0, -r1
mul_sat r2.w, r2, r1
mad_pp r0.xyz, r2.w, r0, r1
pow_pp r1, r3.x, c5.x
add_pp r1.w, r0, c17.x
mov_pp r3.x, r1
mov r1.xyz, c2
mul r1.xyz, c3, r1
mul r1.xyz, r1, r3.x
add_pp_sat r2.y, r2, -r2.z
mul r1.xyz, r2.y, r1
add_pp r3.x, r2, c16.z
mul r2.xyz, r0.w, r1
mul_pp r1.x, r3, c2.w
mul_pp_sat r3.x, r1, c16.w
mov r0.w, c9.x
add r1.xyz, c2, r0.w
mad_sat r1.xyz, r1, r3.x, c0
add_pp r1.xyz, r1, r2
mad_pp r0.w, r2, r1, c17.y
mul_pp r0.xyz, r0, c4
mul r3.xyz, r1, c11.x
mad_sat r2.xyz, r1, c10.x, -r0.w
mad_pp r0.xyz, r0, r2, r3
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 119 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord5 v4.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r1.xyz, r0.x, v4
abs r3.xyz, r1
abs r2.y, r1
add r0.w, r3.z, -r3.x
add r2.z, -r2.y, c12.y
mad r2.w, r2.y, c12.z, c12
mad r2.w, r2, r2.y, c13.x
mad r2.y, r2.w, r2, c13
rsq r2.z, r2.z
rcp r2.z, r2.z
add r0.xyz, r3.zxyw, -r3
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r3
add r0.w, -r3.y, r0.x
add r0.xyz, -r3.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r3.yxzw
abs r1.w, r1.z
dsx r3.zw, r1.xyxz
mul r3.zw, r3, r3
abs_pp r0.x, r0
rcp_pp r0.x, r0.x
mul_pp r0.xy, r0.zyzw, r0.x
max r0.w, r3.x, r1
rcp r0.z, r0.w
min r0.w, r3.x, r1
mul r0.z, r0.w, r0
mul r0.w, r0.z, r0.z
mad r2.x, r0.w, c14.y, c14.z
mul_pp r0.xy, r0, c16.y
mad r2.x, r2, r0.w, c14.w
cmp r2.w, r1.y, c12.x, c12.y
mul r2.z, r2.y, r2
mad r1.y, r2.x, r0.w, c15.x
mul r2.y, r2.w, r2.z
mad r2.x, -r2.y, c13.z, r2.z
mad r1.y, r1, r0.w, c15
mad r1.y, r1, r0.w, c15.z
mad r2.x, r2.w, c13.w, r2
mul r0.w, r2.x, c14.x
dsy r2.xz, r1
mul r2.xz, r2, r2
mul r1.y, r1, r0.z
add r0.z, r2.x, r2
add r3.y, r3.z, r3.w
rsq r2.x, r3.y
rsq r0.z, r0.z
rcp r0.z, r0.z
rcp r2.x, r2.x
dsx r2.y, r0.w
dsy r2.w, r0
mul r2.z, r0, c16.x
add r3.y, -r1, c15.w
add r1.w, r3.x, -r1
cmp r3.w, -r1, r1.y, r3.y
add r1.y, -r3.w, c13.w
cmp r1.y, r1.z, r3.w, r1
cmp r1.y, r1.x, r1, -r1
mul r1.w, v0.x, c8.x
dp4 r1.x, c1, c1
mul_sat r1.z, r1.w, c13
mul r2.x, r2, c16
mul r0.xy, r0, c7.x
texldd r0.xyz, r0, s1, r2, r2.zwzw
add_pp r3.xyz, -r0, c12.y
mad_pp r0.xyz, r1.z, r3, r0
mad r3.x, r1.y, c16, c16.y
mov r3.y, r0.w
texldd r2, r3, s0, r2, r2.zwzw
rsq r1.x, r1.x
mul r1.xyz, r1.x, c1
dp3_pp r0.w, v2, -r1
mul_pp r3.xyz, v2, r0.w
mad_pp r3.xyz, -r3, c13.z, -r1
mul r0.w, v0.x, c6.x
mul r3.w, r0, r0
add_pp r2.xyz, r2, -r0
mul_sat r0.w, r3, r0
mad_pp r0.xyz, r0.w, r2, r0
dp3_pp_sat r2.y, v2, r1
dp3_pp_sat r1.w, r3, v1
pow_pp r3, r1.w, c5.x
add_pp r2.x, r2.w, c17
mad_pp r0.w, r0, r2.x, c17.y
dp3 r1.x, v3, v3
mov_pp r2.z, r3.x
rcp r1.w, v3.w
mad r3.xy, v3, r1.w, c16.y
texld r1.w, r3, s2
add_pp r3.y, r2, c12
cmp r1.y, -v3.z, c12.x, c12
add_pp r2.y, r2, c16.z
mul_pp r1.y, r1, r1.w
texld r1.x, r1.x, s3
mul_pp r1.w, r1.y, r1.x
mul r1.xyz, r1.w, c2
mul_pp r2.y, r2, c2.w
mul_pp r1.w, r2.y, r1
mul r1.xyz, r1, c3
mul r1.xyz, r1, r2.z
frc_pp r3.x, r3.y
add_pp_sat r2.z, r3.y, -r3.x
mul r1.xyz, r2.z, r1
mov r2.y, c9.x
add r3.xyz, c2, r2.y
mul_pp_sat r1.w, r1, c16
mad_sat r3.xyz, r3, r1.w, c0
mul r1.xyz, r2.w, r1
add_pp r1.xyz, r3, r1
mul_pp r0.xyz, r0, c4
mul r2.xyz, r1, c11.x
mad_sat r3.xyz, r1, c10.x, -r0.w
mad_pp r0.xyz, r0, r3, r2
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 115 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord5 v4.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r3.xyz, r0.x, v4
abs r2.xyz, r3
abs r1.y, r3
add r0.w, r2.z, -r2.x
add r1.w, -r1.y, c12.y
mad r1.z, r1.y, c12, c12.w
mad r1.z, r1, r1.y, c13.x
rsq r1.w, r1.w
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs r2.y, r3.z
max r0.w, r2.x, r2.y
abs_pp r0.x, r0
rcp_pp r0.x, r0.x
mul_pp r0.xy, r0.zyzw, r0.x
min r0.z, r2.x, r2.y
rcp r0.w, r0.w
mul r0.z, r0, r0.w
mul r0.w, r0.z, r0.z
mad r1.x, r0.w, c14.y, c14.z
mad r1.x, r1, r0.w, c14.w
mul_pp r0.xy, r0, c16.y
mad r2.z, r1.x, r0.w, c15.x
mad r1.y, r1.z, r1, c13
rcp r1.w, r1.w
mul r1.z, r1.y, r1.w
cmp r1.y, r3, c12.x, c12
mul r1.w, r1.y, r1.z
mad r1.x, -r1.w, c13.z, r1.z
mad r1.z, r2, r0.w, c15.y
mad r1.x, r1.y, c13.w, r1
mad r1.y, r1.z, r0.w, c15.z
mul r0.w, r1.x, c14.x
mul r3.y, r1, r0.z
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r0.z, r2, r2.w
dsy r1.xz, r3
mul r1.xz, r1, r1
add r1.x, r1, r1.z
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c16.x
add r2.z, -r3.y, c15.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c13
mul r3.y, v0.x, c8.x
cmp r2.w, r3.z, r2, r3
mul r1.x, r1, c16
mul r0.xy, r0, c7.x
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c12.y
mul_sat r3.y, r3, c13.z
mad_pp r0.xyz, r3.y, r2, r0
cmp r2.x, r3, r2.w, -r2.w
mad r3.x, r2, c16, c16.y
mov r3.y, r0.w
texldd r1, r3, s0, r1.zwzw, r1
dp4 r2.y, c1, c1
rsq r2.x, r2.y
mul r2.xyz, r2.x, c1
dp3_pp r0.w, v2, -r2
mul_pp r3.xyz, v2, r0.w
mad_pp r3.xyz, -r3, c13.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c12
mul r0.w, v0.x, c6.x
frc_pp r2.z, r2.y
mul r2.w, r0, r0
dp3_pp_sat r3.x, r3, v1
add_pp r1.xyz, r1, -r0
mul_sat r2.w, r2, r0
mad_pp r1.xyz, r2.w, r1, r0
pow_pp r0, r3.x, c5.x
mov_pp r3.y, r0.x
dp3 r0.x, v3, v3
add_pp r3.x, r1.w, c17
texld r0.x, r0.x, s2
texld r0.w, v3, s3
mul r0.w, r0.x, r0
mul r0.xyz, r0.w, c2
mul r0.xyz, r0, c3
mul r0.xyz, r0, r3.y
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c16.z
mul r0.xyz, r2.y, r0
mul_pp r3.y, r2.x, c2.w
mul r2.xyz, r1.w, r0
mul_pp r0.y, r3, r0.w
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c2, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mad_pp r0.w, r2, r3.x, c17.y
add_pp r0.xyz, r0, r2
mul_pp r1.xyz, r1, c4
mul r3.xyz, r0, c11.x
mad_sat r2.xyz, r0, c10.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 113 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord5 v4.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r3.xyz, r0.x, v4
abs r2.xyz, r3
add r0.w, r2.z, -r2.x
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs_pp r0.x, r0
rcp_pp r0.w, r0.x
abs r2.y, r3.z
mul_pp r0.zw, r0.xyzy, r0.w
max r0.x, r2, r2.y
mul_pp r0.zw, r0, c16.y
rcp r0.y, r0.x
min r0.x, r2, r2.y
mul r0.x, r0, r0.y
mul r1.xy, r0.zwzw, c7.x
abs r0.w, r3.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c14.y, c14
mad r0.z, r0, r0.y, c14.w
add r1.w, -r0, c12.y
mad r1.z, r0.w, c12, c12.w
mad r1.z, r1, r0.w, c13.x
rsq r1.w, r1.w
mad r2.z, r0, r0.y, c15.x
mad r0.w, r1.z, r0, c13.y
rcp r1.w, r1.w
mul r1.z, r0.w, r1.w
cmp r0.w, r3.y, c12.x, c12.y
mul r1.w, r0, r1.z
mad r0.z, -r1.w, c13, r1
mad r1.z, r2, r0.y, c15.y
mad r0.z, r0.w, c13.w, r0
mul r1.w, r0.z, c14.x
mad r0.y, r1.z, r0, c15.z
mul r3.y, r0, r0.x
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r1.z, r2, r2.w
dsy r0.xz, r3
mul r0.xz, r0, r0
add r0.z, r0.x, r0
rsq r0.x, r1.z
rsq r0.z, r0.z
dsx r0.w, r1
dsy r0.y, r1.w
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
texldd r1.xyz, r1, s1, r0.zwzw, r0
add r2.z, -r3.y, c15.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c13
cmp r2.w, r3.z, r2, r3
mul r3.y, v0.x, c8.x
add_pp r2.xyz, -r1, c12.y
mul_sat r3.y, r3, c13.z
mad_pp r1.xyz, r3.y, r2, r1
cmp r2.x, r3, r2.w, -r2.w
mad r3.x, r2, c16, c16.y
mov r3.y, r1.w
texldd r0, r3, s0, r0.zwzw, r0
dp4_pp r2.y, c1, c1
rsq_pp r2.x, r2.y
mul_pp r2.xyz, r2.x, c1
dp3_pp r1.w, v2, -r2
mul_pp r3.xyz, v2, r1.w
mad_pp r3.xyz, -r3, c13.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c12
mul r1.w, v0.x, c6.x
frc_pp r2.z, r2.y
mul r2.w, r1, r1
dp3_pp_sat r3.x, r3, v1
add_pp r0.xyz, r0, -r1
mul_sat r2.w, r2, r1
mad_pp r0.xyz, r2.w, r0, r1
pow_pp r1, r3.x, c5.x
mov_pp r3.x, r1
texld r3.w, v3, s2
mul r1.xyz, r3.w, c2
mul r1.xyz, r1, c3
mul r1.xyz, r1, r3.x
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c16.z
mul r1.xyz, r2.y, r1
mul_pp r3.x, r2, c2.w
mul r2.xyz, r0.w, r1
mul_pp r1.x, r3, r3.w
add_pp r1.w, r0, c17.x
mul_pp_sat r3.x, r1, c16.w
mov r0.w, c9.x
add r1.xyz, c2, r0.w
mad_sat r1.xyz, r1, r3.x, c0
add_pp r1.xyz, r1, r2
mad_pp r0.w, r2, r1, c17.y
mul_pp r0.xyz, r0, c4
mul r3.xyz, r1, c11.x
mad_sat r2.xyz, r1, c10.x, -r0.w
mad_pp r0.xyz, r0, r2, r3
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_MainTexHandoverDist]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_LightPower]
Float 12 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 122 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c13, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c14, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r0.xyz, r0.x, v5
abs r1.xyz, r0
add r0.w, r1.z, -r1.x
add r2.xyz, r1.zxyw, -r1
cmp r0.w, r0, c13.y, c13.x
mad r2.xyz, r0.w, r2, r1
add r0.w, -r1.y, r2.x
add r2.xyz, -r1.yxzw, r2
cmp r0.w, r0, c13.y, c13.x
mad r2.xyz, r0.w, r2, r1.yxzw
abs_pp r1.y, r2.x
abs r0.w, r0.z
rcp_pp r1.y, r1.y
mul_pp r1.zw, r2.xyzy, r1.y
abs r2.z, r0.y
max r2.x, r1, r0.w
rcp r1.y, r2.x
min r2.x, r1, r0.w
mul r1.y, r2.x, r1
mul r2.x, r1.y, r1.y
mad r2.y, r2.x, c15, c15.z
add r2.w, -r2.z, c13.y
mad r3.x, r2.z, c13.z, c13.w
mad r3.x, r3, r2.z, c14
mad r2.z, r3.x, r2, c14.y
mul_pp r1.zw, r1, c17.y
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r1.zw, r1, c8.x
mad r2.y, r2, r2.x, c15.w
cmp r3.x, r0.y, c13, c13.y
mul r2.w, r2.z, r2
mad r0.y, r2, r2.x, c16.x
mad r0.y, r0, r2.x, c16
mul r2.z, r3.x, r2.w
mad r2.y, -r2.z, c14.z, r2.w
mad r2.x, r0.y, r2, c16.z
mad r2.y, r3.x, c14.w, r2
mul r0.y, r2, c15.x
mul r1.y, r2.x, r1
dsx r2.zw, r0.xyxz
mul r2.zw, r2, r2
dsy r2.xy, r0.xzzw
mul r2.xy, r2, r2
add r2.x, r2, r2.y
add r2.z, r2, r2.w
rsq r2.y, r2.z
rcp r2.y, r2.y
rsq r2.x, r2.x
rcp r2.x, r2.x
dsx r3.y, r0
dsy r3.w, r0.y
mul r3.x, r2.y, c17
mul r3.z, r2.x, c17.x
texldd r2.xyz, r1.zwzw, s1, r3, r3.zwzw
add r0.w, r1.x, -r0
add r1.z, -r1.y, c16.w
cmp r2.w, -r0, r1.y, r1.z
add r1.w, -r2, c14
cmp r0.z, r0, r2.w, r1.w
cmp r0.x, r0, r0.z, -r0.z
mul r0.w, v0.x, c9.x
dp4 r0.z, c1, c1
add_pp r1.xyz, -r2, c13.y
mul_sat r0.w, r0, c14.z
mad_pp r1.xyz, r0.w, r1, r2
rsq r0.z, r0.z
mul r2.xyz, r0.z, c1
mad r0.x, r0, c17, c17.y
texldd r0, r0, s0, r3, r3.zwzw
dp3_pp r1.w, v2, -r2
mul_pp r3.xyz, v2, r1.w
mad_pp r3.xyz, -r3, c14.z, -r2
dp3_pp_sat r2.y, v2, r2
mul r1.w, v0.x, c7.x
mul r3.w, r1, r1
add_pp r0.xyz, r0, -r1
mul_sat r1.w, r3, r1
mad_pp r0.xyz, r1.w, r0, r1
dp3_pp_sat r2.w, r3, v1
pow_pp r3, r2.w, c6.x
add_pp r3.y, r2, c13
add_pp r1.z, r0.w, c18.x
texldp r1.x, v4, s4
rcp r1.y, v4.w
mad r1.y, -v4.z, r1, r1.x
mov r1.x, c2
cmp r2.z, r1.y, c13.y, r1.x
rcp r2.x, v3.w
mad r1.xy, v3, r2.x, c17.y
texld r2.w, r1, s2
dp3 r2.x, v3, v3
cmp r1.y, -v3.z, c13.x, c13
mul_pp r1.y, r1, r2.w
texld r1.x, r2.x, s3
mul_pp r1.x, r1.y, r1
mul_pp r1.x, r1, r2.z
mul r2.xzw, r1.x, c3.xyyz
frc_pp r1.y, r3
mul r2.xzw, r2, c4.xyyz
mul r2.xzw, r2, r3.x
add_pp_sat r1.y, r3, -r1
add_pp r3.x, r2.y, c17.z
mul r2.xyz, r1.y, r2.xzww
mul_pp r1.y, r3.x, c3.w
mul r2.xyz, r0.w, r2
mul_pp r0.w, r1.y, r1.x
mov r1.x, c10
mul_pp_sat r0.w, r0, c17
add r3.xyz, c3, r1.x
mad_sat r3.xyz, r3, r0.w, c0
mad_pp r0.w, r1, r1.z, c18.y
add_pp r2.xyz, r3, r2
mul_pp r0.xyz, r0, c5
mul r1.xyz, r2, c12.x
mad_sat r3.xyz, r2, c11.x, -r0.w
mad_pp r0.xyz, r0, r3, r1
mul_pp oC0.xyz, r0, r2
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightShadowData]
Vector 3 [_LightColor0]
Vector 4 [_SpecColor]
Vector 5 [_Color]
Float 6 [_Shininess]
Float 7 [_MainTexHandoverDist]
Float 8 [_DetailScale]
Float 9 [_DetailDist]
Float 10 [_MinLight]
Float 11 [_LightPower]
Float 12 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 122 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c13, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c14, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c15, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c16, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c17, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c18, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r1.xyz, r0.x, v5
abs r3.xyz, r1
abs r2.y, r1
add r0.w, r3.z, -r3.x
add r2.z, -r2.y, c13.y
mad r2.w, r2.y, c13.z, c13
mad r2.w, r2, r2.y, c14.x
mad r2.y, r2.w, r2, c14
rsq r2.z, r2.z
rcp r2.z, r2.z
add r0.xyz, r3.zxyw, -r3
cmp r0.w, r0, c13.y, c13.x
mad r0.xyz, r0.w, r0, r3
add r0.w, -r3.y, r0.x
add r0.xyz, -r3.yxzw, r0
cmp r0.w, r0, c13.y, c13.x
mad r0.xyz, r0.w, r0, r3.yxzw
abs r1.w, r1.z
dsx r3.zw, r1.xyxz
mul r3.zw, r3, r3
abs_pp r0.x, r0
rcp_pp r0.x, r0.x
mul_pp r0.xy, r0.zyzw, r0.x
max r0.w, r3.x, r1
rcp r0.z, r0.w
min r0.w, r3.x, r1
mul r0.z, r0.w, r0
mul r0.w, r0.z, r0.z
mad r2.x, r0.w, c15.y, c15.z
mul_pp r0.xy, r0, c17.y
mad r2.x, r2, r0.w, c15.w
cmp r2.w, r1.y, c13.x, c13.y
mul r2.z, r2.y, r2
mad r1.y, r2.x, r0.w, c16.x
mul r2.y, r2.w, r2.z
mad r2.x, -r2.y, c14.z, r2.z
mad r1.y, r1, r0.w, c16
mad r1.y, r1, r0.w, c16.z
mad r2.x, r2.w, c14.w, r2
mul r0.w, r2.x, c15.x
dsy r2.xz, r1
mul r2.xz, r2, r2
mul r1.y, r1, r0.z
add r0.z, r2.x, r2
add r3.y, r3.z, r3.w
rsq r2.x, r3.y
rsq r0.z, r0.z
rcp r0.z, r0.z
rcp r2.x, r2.x
dsx r2.y, r0.w
dsy r2.w, r0
mul r2.z, r0, c17.x
add r3.y, -r1, c16.w
add r1.w, r3.x, -r1
cmp r3.w, -r1, r1.y, r3.y
add r1.y, -r3.w, c14.w
cmp r1.y, r1.z, r3.w, r1
cmp r1.y, r1.x, r1, -r1
mul r1.w, v0.x, c9.x
dp4 r1.x, c1, c1
mul_sat r1.z, r1.w, c14
mul r2.x, r2, c17
mul r0.xy, r0, c8.x
texldd r0.xyz, r0, s1, r2, r2.zwzw
add_pp r3.xyz, -r0, c13.y
mad_pp r0.xyz, r1.z, r3, r0
mad r3.x, r1.y, c17, c17.y
mov r3.y, r0.w
texldd r2, r3, s0, r2, r2.zwzw
rsq r1.x, r1.x
mul r1.xyz, r1.x, c1
dp3_pp r0.w, v2, -r1
mul_pp r3.xyz, v2, r0.w
mad_pp r3.xyz, -r3, c14.z, -r1
mul r0.w, v0.x, c7.x
mul r3.w, r0, r0
add_pp r2.xyz, r2, -r0
mul_sat r0.w, r3, r0
mad_pp r0.xyz, r0.w, r2, r0
mul_pp r2.xyz, r0, c5
dp3_pp_sat r0.z, v2, r1
dp3_pp_sat r1.w, r3, v1
pow_pp r3, r1.w, c6.x
add_pp r3.y, r0.z, c13
add_pp r0.y, r2.w, c18.x
mad_pp r0.w, r0, r0.y, c18.y
mov r0.x, c2
add r1.x, c13.y, -r0
texldp r0.x, v4, s4
mad r1.z, r0.x, r1.x, c2.x
rcp r1.y, v3.w
mad r1.xy, v3, r1.y, c17.y
texld r1.w, r1, s2
dp3 r0.x, v3, v3
cmp r1.x, -v3.z, c13, c13.y
mul_pp r1.x, r1, r1.w
frc_pp r1.w, r3.y
texld r0.x, r0.x, s3
mul_pp r0.x, r1, r0
mul_pp r0.x, r0, r1.z
mul r1.xyz, r0.x, c3
mul r1.xyz, r1, c4
add_pp r0.z, r0, c17
mul_pp r0.z, r0, c3.w
mul_pp r0.x, r0.z, r0
mul r1.xyz, r1, r3.x
add_pp_sat r1.w, r3.y, -r1
mov r0.z, c10.x
mul r1.xyz, r1.w, r1
mul_pp_sat r0.x, r0, c17.w
add r3.xyz, c3, r0.z
mad_sat r3.xyz, r3, r0.x, c0
mul r1.xyz, r2.w, r1
add_pp r1.xyz, r3, r1
mul r0.xyz, r1, c12.x
mad_sat r3.xyz, r1, c11.x, -r0.w
mad_pp r0.xyz, r2, r3, r0
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 113 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord5 v4.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r3.xyz, r0.x, v4
abs r2.xyz, r3
add r0.w, r2.z, -r2.x
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs_pp r0.x, r0
rcp_pp r0.w, r0.x
abs r2.y, r3.z
mul_pp r0.zw, r0.xyzy, r0.w
max r0.x, r2, r2.y
mul_pp r0.zw, r0, c16.y
rcp r0.y, r0.x
min r0.x, r2, r2.y
mul r0.x, r0, r0.y
mul r1.xy, r0.zwzw, c7.x
abs r0.w, r3.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c14.y, c14
mad r0.z, r0, r0.y, c14.w
add r1.w, -r0, c12.y
mad r1.z, r0.w, c12, c12.w
mad r1.z, r1, r0.w, c13.x
rsq r1.w, r1.w
mad r2.z, r0, r0.y, c15.x
mad r0.w, r1.z, r0, c13.y
rcp r1.w, r1.w
mul r1.z, r0.w, r1.w
cmp r0.w, r3.y, c12.x, c12.y
mul r1.w, r0, r1.z
mad r0.z, -r1.w, c13, r1
mad r1.z, r2, r0.y, c15.y
mad r0.z, r0.w, c13.w, r0
mul r1.w, r0.z, c14.x
mad r0.y, r1.z, r0, c15.z
mul r3.y, r0, r0.x
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r1.z, r2, r2.w
dsy r0.xz, r3
mul r0.xz, r0, r0
add r0.z, r0.x, r0
rsq r0.x, r1.z
rsq r0.z, r0.z
dsx r0.w, r1
dsy r0.y, r1.w
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
texldd r1.xyz, r1, s1, r0.zwzw, r0
add r2.z, -r3.y, c15.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c13
mul r3.y, v0.x, c8.x
add_pp r2.xyz, -r1, c12.y
mul_sat r3.y, r3, c13.z
mad_pp r1.xyz, r3.y, r2, r1
cmp r2.w, r3.z, r2, r3
cmp r2.x, r3, r2.w, -r2.w
mad r3.x, r2, c16, c16.y
mov r3.y, r1.w
texldd r0, r3, s0, r0.zwzw, r0
dp4_pp r2.y, c1, c1
rsq_pp r2.x, r2.y
mul_pp r2.xyz, r2.x, c1
dp3_pp r1.w, v2, -r2
mul_pp r3.xyz, v2, r1.w
mad_pp r3.xyz, -r3, c13.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c12
mul r1.w, v0.x, c6.x
frc_pp r2.z, r2.y
mul r2.w, r1, r1
dp3_pp_sat r3.x, r3, v1
add_pp r0.xyz, r0, -r1
mul_sat r2.w, r2, r1
mad_pp r0.xyz, r2.w, r0, r1
pow_pp r1, r3.x, c5.x
mov_pp r3.y, r1.x
texldp r3.x, v3, s2
mul r1.xyz, r3.x, c2
mul r1.xyz, r1, c3
mul r1.xyz, r1, r3.y
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c16.z
mul r1.xyz, r2.y, r1
mul_pp r3.y, r2.x, c2.w
mul r2.xyz, r0.w, r1
mul_pp r1.x, r3.y, r3
add_pp r1.w, r0, c17.x
mul_pp_sat r3.x, r1, c16.w
mov r0.w, c9.x
add r1.xyz, c2, r0.w
mad_sat r1.xyz, r1, r3.x, c0
add_pp r1.xyz, r1, r2
mad_pp r0.w, r2, r1, c17.y
mul_pp r0.xyz, r0, c4
mul r3.xyz, r1, c11.x
mad_sat r2.xyz, r1, c10.x, -r0.w
mad_pp r0.xyz, r0, r2, r3
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightColor0]
Vector 3 [_SpecColor]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_MainTexHandoverDist]
Float 7 [_DetailScale]
Float 8 [_DetailDist]
Float 9 [_MinLight]
Float 10 [_LightPower]
Float 11 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 113 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c12, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c13, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c14, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c15, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c16, 0.15915494, 0.50000000, -0.01000214, 4.03944778
def c17, -0.44897461, 0.44897461, 0, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r2.xyz, r3
add r0.w, r2.z, -r2.x
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c12.y, c12.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs_pp r0.x, r0
rcp_pp r0.w, r0.x
abs r2.y, r3.z
mul_pp r0.zw, r0.xyzy, r0.w
max r0.x, r2, r2.y
mul_pp r0.zw, r0, c16.y
rcp r0.y, r0.x
min r0.x, r2, r2.y
mul r0.x, r0, r0.y
mul r1.xy, r0.zwzw, c7.x
abs r0.w, r3.y
mul r0.y, r0.x, r0.x
mad r0.z, r0.y, c14.y, c14
mad r0.z, r0, r0.y, c14.w
add r1.w, -r0, c12.y
mad r1.z, r0.w, c12, c12.w
mad r1.z, r1, r0.w, c13.x
rsq r1.w, r1.w
mad r2.z, r0, r0.y, c15.x
mad r0.w, r1.z, r0, c13.y
rcp r1.w, r1.w
mul r1.z, r0.w, r1.w
cmp r0.w, r3.y, c12.x, c12.y
mul r1.w, r0, r1.z
mad r0.z, -r1.w, c13, r1
mad r1.z, r2, r0.y, c15.y
mad r0.z, r0.w, c13.w, r0
mul r1.w, r0.z, c14.x
mad r0.y, r1.z, r0, c15.z
mul r3.y, r0, r0.x
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r1.z, r2, r2.w
dsy r0.xz, r3
mul r0.xz, r0, r0
add r0.z, r0.x, r0
rsq r0.x, r1.z
rsq r0.z, r0.z
dsx r0.w, r1
dsy r0.y, r1.w
rcp r1.z, r0.z
rcp r0.x, r0.x
mul r0.z, r0.x, c16.x
mul r0.x, r1.z, c16
texldd r1.xyz, r1, s1, r0.zwzw, r0
add r2.z, -r3.y, c15.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c13
mul r3.y, v0.x, c8.x
add_pp r2.xyz, -r1, c12.y
mul_sat r3.y, r3, c13.z
mad_pp r1.xyz, r3.y, r2, r1
cmp r2.w, r3.z, r2, r3
cmp r2.x, r3, r2.w, -r2.w
mul r2.w, v0.x, c6.x
mul r3.w, r2, r2
mad r3.x, r2, c16, c16.y
mov r3.y, r1.w
texldd r0, r3, s0, r0.zwzw, r0
dp4_pp r2.y, c1, c1
rsq_pp r2.x, r2.y
mul_pp r2.xyz, r2.x, c1
dp3_pp r1.w, v2, -r2
mul_pp r3.xyz, v2, r1.w
mad_pp r3.xyz, -r3, c13.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c12
frc_pp r2.z, r2.y
add_pp r0.xyz, r0, -r1
mul_sat r2.w, r3, r2
mad_pp r0.xyz, r2.w, r0, r1
dp3_pp_sat r1.w, r3, v1
pow_pp r3, r1.w, c5.x
mul_pp r1.xyz, r0, c4
add_pp r3.y, r0.w, c17.x
texldp r0.x, v4, s2
texld r1.w, v3, s3
mul r1.w, r1, r0.x
mul r0.xyz, r1.w, c2
mul r0.xyz, r0, c3
mul r0.xyz, r0, r3.x
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c16.z
mul r0.xyz, r2.y, r0
mul_pp r3.x, r2, c2.w
mul r2.xyz, r0.w, r0
mul_pp r0.y, r3.x, r1.w
mul_pp_sat r0.w, r0.y, c16
mov r0.x, c9
add r0.xyz, c2, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mad_pp r0.w, r2, r3.y, c17.y
add_pp r0.xyz, r0, r2
mul r3.xyz, r0, c11.x
mad_sat r2.xyz, r0, c10.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightPositionRange]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_MainTexHandoverDist]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_LightPower]
Float 13 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 123 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r1.xyz, r3
add r0.w, r1.z, -r1.x
dsy r2.zw, r3.xyxz
add r0.xyz, r1.zxyw, -r1
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r1
add r0.w, -r1.y, r0.x
mul r2.zw, r2, r2
abs r1.w, r3.z
add r0.xyz, -r1.yxzw, r0
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r1.yxzw
abs r1.z, r3.y
max r0.w, r1.x, r1
abs_pp r1.y, r0.x
add r2.y, -r1.z, c14
mad r2.x, r1.z, c14.z, c14.w
mad r2.x, r2, r1.z, c15
rsq r2.y, r2.y
min r0.x, r1, r1.w
rcp r0.w, r0.w
mul r0.w, r0.x, r0
rcp_pp r0.x, r1.y
mul_pp r0.xy, r0.zyzw, r0.x
mul r1.y, r0.w, r0.w
mad r0.z, r1.y, c16.y, c16
mad r0.z, r0, r1.y, c16.w
mad r0.z, r0, r1.y, c17.x
mad r0.z, r0, r1.y, c17.y
mad r1.y, r0.z, r1, c17.z
mul_pp r0.xy, r0, c18.y
mul r1.y, r1, r0.w
mad r1.z, r2.x, r1, c15.y
rcp r2.y, r2.y
mul r2.x, r1.z, r2.y
cmp r1.z, r3.y, c14.x, c14.y
mul r2.y, r1.z, r2.x
mad r0.z, -r2.y, c15, r2.x
mad r0.z, r1, c15.w, r0
mul r0.w, r0.z, c16.x
add r0.z, r1.x, -r1.w
add r1.z, -r1.y, c17.w
cmp r3.y, -r0.z, r1, r1.z
add r1.x, r2.z, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.z, r2.x, r2.y
add r2.w, -r3.y, c15
cmp r2.w, r3.z, r3.y, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c18.x
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c10.x
mul r1.x, r1, c18
mul r0.xy, r0, c9.x
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c14.y
mul_sat r3.x, r3.y, c15.z
mad_pp r0.xyz, r3.x, r2, r0
mad r2.x, r2.w, c18, c18.y
mov r2.y, r0.w
texldd r1, r2, s0, r1.zwzw, r1
dp4 r2.z, c1, c1
rsq r0.w, r2.z
mul r2.xyz, r0.w, c1
dp3_pp r2.w, v2, -r2
mul_pp r3.xyz, v2, r2.w
mad_pp r3.xyz, -r3, c15.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c14
mul r0.w, v0.x, c8.x
frc_pp r2.z, r2.y
mul r2.w, r0, r0
add_pp r1.xyz, r1, -r0
mul_sat r2.w, r2, r0
mad_pp r0.xyz, r2.w, r1, r0
dp3_pp_sat r3.x, r3, v1
mul_pp r1.xyz, r0, c6
pow_pp r0, r3.x, c7.x
dp3 r0.y, v4, v4
rsq r3.z, r0.y
mov_pp r3.y, r0.x
texld r0, v4, s2
dp4 r0.y, r0, c19
rcp r3.z, r3.z
mul r0.x, r3.z, c2.w
mad r0.y, -r0.x, c18.w, r0
mov r0.z, c3.x
dp3 r0.x, v3, v3
add_pp r3.x, r1.w, c20.y
cmp r0.y, r0, c14, r0.z
texld r0.x, r0.x, s3
mul r0.w, r0.x, r0.y
mul r0.xyz, r0.w, c4
mul r0.xyz, r0, c5
mul r0.xyz, r0, r3.y
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c18.z
mul r0.xyz, r2.y, r0
mul_pp r3.y, r2.x, c4.w
mul r2.xyz, r1.w, r0
mul_pp r0.y, r3, r0.w
mul_pp_sat r0.w, r0.y, c20.x
mov r0.x, c11
add r0.xyz, c4, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mad_pp r0.w, r2, r3.x, c20.z
add_pp r0.xyz, r0, r2
mul r3.xyz, r0, c13.x
mad_sat r2.xyz, r0, c12.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightPositionRange]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_MainTexHandoverDist]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_LightPower]
Float 13 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 124 ALU, 9 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r2.xyz, r3
abs r1.y, r3
add r0.w, r2.z, -r2.x
add r1.w, -r1.y, c14.y
mad r1.z, r1.y, c14, c14.w
mad r1.z, r1, r1.y, c15.x
rsq r1.w, r1.w
add r0.xyz, r2.zxyw, -r2
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r2
add r0.w, -r2.y, r0.x
add r0.xyz, -r2.yxzw, r0
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r2.yxzw
abs r2.y, r3.z
max r0.w, r2.x, r2.y
abs_pp r0.x, r0
rcp_pp r0.x, r0.x
mul_pp r0.xy, r0.zyzw, r0.x
min r0.z, r2.x, r2.y
rcp r0.w, r0.w
mul r0.z, r0, r0.w
mul r0.w, r0.z, r0.z
mad r1.x, r0.w, c16.y, c16.z
mad r1.x, r1, r0.w, c16.w
mul_pp r0.xy, r0, c18.y
mad r2.z, r1.x, r0.w, c17.x
mad r1.y, r1.z, r1, c15
rcp r1.w, r1.w
mul r1.z, r1.y, r1.w
cmp r1.y, r3, c14.x, c14
mul r1.w, r1.y, r1.z
mad r1.x, -r1.w, c15.z, r1.z
mad r1.z, r2, r0.w, c17.y
mad r1.x, r1.y, c15.w, r1
mad r1.y, r1.z, r0.w, c17.z
mul r0.w, r1.x, c16.x
mul r3.y, r1, r0.z
dsx r2.zw, r3.xyxz
mul r2.zw, r2, r2
add r0.z, r2, r2.w
dsy r1.xz, r3
mul r1.xz, r1, r1
add r1.x, r1, r1.z
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c18.x
add r2.z, -r3.y, c17.w
add r2.x, r2, -r2.y
cmp r2.w, -r2.x, r3.y, r2.z
add r3.w, -r2, c15
mul r3.y, v0.x, c10.x
cmp r2.w, r3.z, r2, r3
mul r1.x, r1, c18
mul r0.xy, r0, c9.x
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c14.y
mul_sat r3.y, r3, c15.z
mad_pp r0.xyz, r3.y, r2, r0
cmp r2.x, r3, r2.w, -r2.w
mad r3.x, r2, c18, c18.y
mov r3.y, r0.w
texldd r1, r3, s0, r1.zwzw, r1
dp4 r2.y, c1, c1
rsq r2.x, r2.y
mul r2.xyz, r2.x, c1
dp3_pp r0.w, v2, -r2
mul_pp r3.xyz, v2, r0.w
mad_pp r3.xyz, -r3, c15.z, -r2
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c14
dp3_pp_sat r3.x, r3, v1
mul r0.w, v0.x, c8.x
frc_pp r2.z, r2.y
mul r2.w, r0, r0
dp3 r3.z, v4, v4
add_pp r1.xyz, r1, -r0
mul_sat r2.w, r2, r0
mad_pp r1.xyz, r2.w, r1, r0
pow_pp r0, r3.x, c7.x
mov_pp r3.y, r0.x
texld r0, v4, s2
dp4 r0.y, r0, c19
rsq r3.z, r3.z
rcp r0.x, r3.z
mul r0.x, r0, c2.w
mad r0.x, -r0, c18.w, r0.y
mov r0.z, c3.x
cmp r0.y, r0.x, c14, r0.z
dp3 r0.x, v3, v3
add_pp r3.x, r1.w, c20.y
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul r0.w, r0.x, r0.y
mul r0.xyz, r0.w, c4
mul r0.xyz, r0, c5
mul r0.xyz, r0, r3.y
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c18.z
mul r0.xyz, r2.y, r0
mul_pp r3.y, r2.x, c4.w
mul r2.xyz, r1.w, r0
mul_pp r0.y, r3, r0.w
mul_pp_sat r0.w, r0.y, c20.x
mov r0.x, c11
add r0.xyz, c4, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mad_pp r0.w, r2, r3.x, c20.z
add_pp r0.xyz, r0, r2
mul_pp r1.xyz, r1, c6
mul r3.xyz, r0, c13.x
mad_sat r2.xyz, r0, c12.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_LightColor0]
Vector 8 [_SpecColor]
Vector 9 [_Color]
Float 10 [_Shininess]
Float 11 [_MainTexHandoverDist]
Float 12 [_DetailScale]
Float 13 [_DetailDist]
Float 14 [_MinLight]
Float 15 [_LightPower]
Float 16 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 132 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c19, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c20, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c21, 0.15915494, 0.50000000, -0.01000214, 0.25000000
def c22, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r1.xyz, r3
add r0.w, r1.z, -r1.x
dsy r2.zw, r3.xyxz
add r0.xyz, r1.zxyw, -r1
cmp r0.w, r0, c17.y, c17.x
mad r0.xyz, r0.w, r0, r1
add r0.w, -r1.y, r0.x
mul r2.zw, r2, r2
abs r1.w, r3.z
add r0.xyz, -r1.yxzw, r0
cmp r0.w, r0, c17.y, c17.x
mad r0.xyz, r0.w, r0, r1.yxzw
abs r1.z, r3.y
max r0.w, r1.x, r1
abs_pp r1.y, r0.x
add r2.y, -r1.z, c17
mad r2.x, r1.z, c17.z, c17.w
mad r2.x, r2, r1.z, c18
rsq r2.y, r2.y
min r0.x, r1, r1.w
rcp r0.w, r0.w
mul r0.w, r0.x, r0
rcp_pp r0.x, r1.y
mul_pp r0.xy, r0.zyzw, r0.x
mul r1.y, r0.w, r0.w
mad r0.z, r1.y, c19.y, c19
mad r0.z, r0, r1.y, c19.w
mad r0.z, r0, r1.y, c20.x
mad r0.z, r0, r1.y, c20.y
mad r1.y, r0.z, r1, c20.z
mul_pp r0.xy, r0, c21.y
mul r1.y, r1, r0.w
mad r1.z, r2.x, r1, c18.y
rcp r2.y, r2.y
mul r2.x, r1.z, r2.y
cmp r1.z, r3.y, c17.x, c17.y
mul r2.y, r1.z, r2.x
mad r0.z, -r2.y, c18, r2.x
mad r0.z, r1, c18.w, r0
mul r0.w, r0.z, c19.x
add r0.z, r1.x, -r1.w
add r1.z, -r1.y, c20.w
cmp r3.y, -r0.z, r1, r1.z
add r1.x, r2.z, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.z, r2.x, r2.y
add r2.w, -r3.y, c18
cmp r2.w, r3.z, r3.y, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c21.x
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c13.x
mul_sat r3.x, r3.y, c18.z
mul r1.x, r1, c21
mul r0.xy, r0, c12.x
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c17.y
mad_pp r0.xyz, r3.x, r2, r0
mov r2.y, r0.w
mad r2.x, r2.w, c21, c21.y
texldd r1, r2, s0, r1.zwzw, r1
dp4 r0.w, c1, c1
rsq r0.w, r0.w
mul r2.xyz, r0.w, c1
dp3_pp r3.x, v2, -r2
mul r0.w, v0.x, c11.x
mul r2.w, r0, r0
mul_pp r3.xyz, v2, r3.x
mad_pp r3.xyz, -r3, c18.z, -r2
dp3_pp_sat r3.y, r3, v1
rcp r3.z, v4.w
dp3_pp_sat r2.x, v2, r2
add_pp r2.y, r2.x, c17
frc_pp r2.z, r2.y
add_pp r1.xyz, r1, -r0
mul_sat r2.w, r2, r0
mad_pp r0.xyz, r2.w, r1, r0
mul_pp r1.xyz, r0, c9
pow_pp r0, r3.y, c10.x
mad r4.xy, v4, r3.z, c6
mov_pp r3.y, r0.x
texld r0.x, r4, s4
mad r4.xy, v4, r3.z, c5
mov r0.w, r0.x
texld r0.x, r4, s4
mad r4.xy, v4, r3.z, c4
mov r0.z, r0.x
texld r0.x, r4, s4
mad r4.xy, v4, r3.z, c3
mov r0.y, r0.x
texld r0.x, r4, s4
mad r0, -v4.z, r3.z, r0
rcp r3.z, v3.w
mov r3.w, c2.x
cmp r0, r0, c17.y, r3.w
dp4_pp r0.y, r0, c21.w
mad r4.xy, v3, r3.z, c21.y
dp3 r0.x, v3, v3
add_pp r3.x, r1.w, c22.y
texld r0.w, r4, s2
cmp r0.z, -v3, c17.x, c17.y
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.z, r0
mul_pp r0.w, r0.x, r0.y
mul r0.xyz, r0.w, c7
mul r0.xyz, r0, c8
mul r0.xyz, r0, r3.y
add_pp_sat r2.y, r2, -r2.z
add_pp r2.x, r2, c21.z
mul r0.xyz, r2.y, r0
mul_pp r3.y, r2.x, c7.w
mul r2.xyz, r1.w, r0
mul_pp r0.y, r3, r0.w
mul_pp_sat r0.w, r0.y, c22.x
mov r0.x, c14
add r0.xyz, c7, r0.x
mad_sat r0.xyz, r0, r0.w, c0
mad_pp r0.w, r2, r3.x, c22.z
add_pp r0.xyz, r0, r2
mul r3.xyz, r0, c16.x
mad_sat r2.xyz, r0, c15.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_LightColor0]
Vector 8 [_SpecColor]
Vector 9 [_Color]
Float 10 [_Shininess]
Float 11 [_MainTexHandoverDist]
Float 12 [_DetailScale]
Float 13 [_DetailDist]
Float 14 [_MinLight]
Float 15 [_LightPower]
Float 16 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 131 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c17, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c18, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c19, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c20, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c21, 0.15915494, 0.50000000, -0.01000214, 0.25000000
def c22, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r1.xyz, r3
add r0.w, r1.z, -r1.x
add r0.xyz, r1.zxyw, -r1
cmp r0.w, r0, c17.y, c17.x
mad r0.xyz, r0.w, r0, r1
add r0.w, -r1.y, r0.x
add r0.xyz, -r1.yxzw, r0
cmp r0.w, r0, c17.y, c17.x
mad r2.xyz, r0.w, r0, r1.yxzw
abs r1.w, r3.z
max r0.x, r1, r1.w
rcp r0.y, r0.x
min r0.x, r1, r1.w
mul r0.z, r0.x, r0.y
abs_pp r0.w, r2.x
rcp_pp r0.x, r0.w
mul_pp r2.xy, r2.zyzw, r0.x
mul r0.w, r0.z, r0.z
mad r0.x, r0.w, c19.y, c19.z
mad r1.y, r0.x, r0.w, c19.w
mul_pp r2.xy, r2, c21.y
mad r1.z, r1.y, r0.w, c20.x
mul r0.xy, r2, c12.x
abs r1.y, r3
mad r2.y, r1.z, r0.w, c20
dsy r2.zw, r3.xyxz
add r2.x, -r1.y, c17.y
mad r1.z, r1.y, c17, c17.w
mad r1.z, r1, r1.y, c18.x
rsq r2.x, r2.x
mul r2.zw, r2, r2
mad r2.y, r2, r0.w, c20.z
mad r1.y, r1.z, r1, c18
rcp r2.x, r2.x
mul r1.z, r1.y, r2.x
cmp r1.y, r3, c17.x, c17
mul r2.x, r1.y, r1.z
mad r0.w, -r2.x, c18.z, r1.z
mul r1.z, r2.y, r0
mad r0.z, r1.y, c18.w, r0.w
mul r0.w, r0.z, c19.x
add r0.z, r1.x, -r1.w
add r1.y, -r1.z, c20.w
cmp r3.y, -r0.z, r1.z, r1
add r1.x, r2.z, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.z, r2.x, r2.y
add r2.w, -r3.y, c18
cmp r2.w, r3.z, r3.y, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c21.x
mul r1.x, r1, c21
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c17.y
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c13.x
mul_sat r3.x, r3.y, c18.z
mad_pp r0.xyz, r3.x, r2, r0
mov r2.y, r0.w
mad r2.x, r2.w, c21, c21.y
texldd r1, r2, s0, r1.zwzw, r1
mul r0.w, v0.x, c11.x
mul r2.x, r0.w, r0.w
rcp r3.x, v4.w
mul_sat r2.w, r2.x, r0
add_pp r1.xyz, r1, -r0
mad_pp r0.xyz, r2.w, r1, r0
mul_pp r1.xyz, r0, c9
mad r0.xyz, v4, r3.x, c6
texld r0.x, r0, s4
mad r2.xyz, v4, r3.x, c5
mov_pp r0.w, r0.x
texld r0.x, r2, s4
mad r2.xyz, v4, r3.x, c4
mov_pp r0.z, r0.x
texld r0.x, r2, s4
mad r2.xyz, v4, r3.x, c3
mov_pp r0.y, r0.x
texld r0.x, r2, s4
mov r2.y, c2.x
add r2.y, c17, -r2
mad r0, r0, r2.y, c2.x
dp4_pp r0.y, r0, c21.w
rcp r0.x, v3.w
mad r4.xy, v3, r0.x, c21.y
dp4 r2.x, c1, c1
rsq r2.x, r2.x
mul r2.xyz, r2.x, c1
dp3_pp r0.z, v2, -r2
mul_pp r3.xyz, v2, r0.z
dp3 r0.x, v3, v3
mad_pp r3.xyz, -r3, c18.z, -r2
texld r0.w, r4, s2
cmp r0.z, -v3, c17.x, c17.y
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.z, r0
mul_pp r4.x, r0, r0.y
add_pp r3.w, r1, c22.y
mul r0.xyz, r4.x, c7
dp3_pp_sat r4.y, r3, v1
mul r3.xyz, r0, c8
pow_pp r0, r4.y, c10.x
dp3_pp_sat r0.w, v2, r2
add_pp r2.x, r0.w, c17.y
frc_pp r2.y, r2.x
add_pp r0.w, r0, c21.z
mul r0.xyz, r3, r0.x
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r2.x, r0
mul_pp r0.w, r0, c7
mul r0.xyz, r1.w, r0
mul_pp r1.w, r0, r4.x
mov r0.w, c14.x
add r2.xyz, c7, r0.w
mad_pp r0.w, r2, r3, c22.z
mul_pp_sat r1.w, r1, c22.x
mad_sat r2.xyz, r2, r1.w, c0
add_pp r0.xyz, r2, r0
mul r3.xyz, r0, c16.x
mad_sat r2.xyz, r0, c15.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightPositionRange]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_MainTexHandoverDist]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_LightPower]
Float 13 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 130 ALU, 11 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.00781250
def c19, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c20, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c21, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r1.xyz, r3
add r0.w, r1.z, -r1.x
add r0.xyz, r1.zxyw, -r1
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r1
add r0.w, -r1.y, r0.x
add r0.xyz, -r1.yxzw, r0
cmp r0.w, r0, c14.y, c14.x
mad r2.xyz, r0.w, r0, r1.yxzw
abs r1.w, r3.z
max r0.x, r1, r1.w
rcp r0.y, r0.x
min r0.x, r1, r1.w
mul r0.z, r0.x, r0.y
abs_pp r0.w, r2.x
rcp_pp r0.x, r0.w
mul_pp r2.xy, r2.zyzw, r0.x
mul r0.w, r0.z, r0.z
mad r0.x, r0.w, c16.y, c16.z
mad r1.y, r0.x, r0.w, c16.w
mul_pp r2.xy, r2, c18.y
mad r1.z, r1.y, r0.w, c17.x
mul r0.xy, r2, c9.x
abs r1.y, r3
mad r2.y, r1.z, r0.w, c17
dsy r2.zw, r3.xyxz
add r2.x, -r1.y, c14.y
mad r1.z, r1.y, c14, c14.w
mad r1.z, r1, r1.y, c15.x
rsq r2.x, r2.x
mul r2.zw, r2, r2
mad r2.y, r2, r0.w, c17.z
mad r1.y, r1.z, r1, c15
rcp r2.x, r2.x
mul r1.z, r1.y, r2.x
cmp r1.y, r3, c14.x, c14
mul r2.x, r1.y, r1.z
mad r0.w, -r2.x, c15.z, r1.z
mul r1.z, r2.y, r0
mad r0.z, r1.y, c15.w, r0.w
mul r0.w, r0.z, c16.x
add r0.z, r1.x, -r1.w
add r1.y, -r1.z, c17.w
cmp r3.y, -r0.z, r1.z, r1
add r1.x, r2.z, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.z, r2.x, r2.y
add r2.w, -r3.y, c15
cmp r2.w, r3.z, r3.y, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c18.x
mul r1.x, r1, c18
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c14.y
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c10.x
mul_sat r3.x, r3.y, c15.z
mad_pp r0.xyz, r3.x, r2, r0
mov r2.y, r0.w
mad r2.x, r2.w, c18, c18.y
texldd r2, r2, s0, r1.zwzw, r1
mul r0.w, v0.x, c8.x
mul r1.w, r0, r0
mul_sat r4.x, r1.w, r0.w
add_pp r1.xyz, r2, -r0
mad_pp r1.xyz, r4.x, r1, r0
mul_pp r2.xyz, r1, c6
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
mul r0.x, r1, c2.w
dp4 r1.x, c1, c1
mad r0, -r0.x, c19.z, r3
mov r1.y, c3.x
cmp r0, r0, c14.y, r1.y
dp4_pp r0.y, r0, c19.w
rsq r1.x, r1.x
mul r1.xyz, r1.x, c1
dp3_pp r0.z, v2, -r1
mul_pp r3.xyz, v2, r0.z
mad_pp r3.xyz, -r3, c15.z, -r1
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
mul r1.w, r0.x, r0.y
mul r0.xyz, r1.w, c4
dp3_pp_sat r3.w, r3, v1
mul r3.xyz, r0, c5
pow_pp r0, r3.w, c7.x
dp3_pp_sat r0.w, v2, r1
add_pp r1.x, r0.w, c14.y
frc_pp r1.y, r1.x
add_pp r0.w, r0, c18.z
add_pp_sat r1.x, r1, -r1.y
mul r0.xyz, r3, r0.x
mul r0.xyz, r1.x, r0
mul_pp r0.w, r0, c4
mul_pp r1.x, r0.w, r1.w
mov r0.w, c11.x
mul_pp_sat r1.w, r1.x, c21.x
add r1.xyz, c4, r0.w
add_pp r4.y, r2.w, c21
mad_pp r0.w, r4.x, r4.y, c21.z
mad_sat r1.xyz, r1, r1.w, c0
mul r0.xyz, r2.w, r0
add_pp r0.xyz, r1, r0
mul r3.xyz, r0, c13.x
mad_sat r1.xyz, r0, c12.x, -r0.w
mad_pp r1.xyz, r2, r1, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [_LightPositionRange]
Vector 3 [_LightShadowData]
Vector 4 [_LightColor0]
Vector 5 [_SpecColor]
Vector 6 [_Color]
Float 7 [_Shininess]
Float 8 [_MainTexHandoverDist]
Float 9 [_DetailScale]
Float 10 [_DetailDist]
Float 11 [_MinLight]
Float 12 [_LightPower]
Float 13 [_Reflectivity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 131 ALU, 12 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
def c14, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c15, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c16, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.15915494, 0.50000000, -0.01000214, 0.00781250
def c19, 0.00781250, -0.00781250, 0.97000003, 0.25000000
def c20, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c21, 4.03944778, -0.44897461, 0.44897461, 0
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r3.xyz, r0.x, v5
abs r1.xyz, r3
add r0.w, r1.z, -r1.x
add r0.xyz, r1.zxyw, -r1
cmp r0.w, r0, c14.y, c14.x
mad r0.xyz, r0.w, r0, r1
add r0.w, -r1.y, r0.x
add r0.xyz, -r1.yxzw, r0
cmp r0.w, r0, c14.y, c14.x
mad r2.xyz, r0.w, r0, r1.yxzw
abs r1.w, r3.z
max r0.x, r1, r1.w
rcp r0.y, r0.x
min r0.x, r1, r1.w
mul r0.z, r0.x, r0.y
abs_pp r0.w, r2.x
rcp_pp r0.x, r0.w
mul_pp r2.xy, r2.zyzw, r0.x
mul r0.w, r0.z, r0.z
mad r0.x, r0.w, c16.y, c16.z
mad r1.y, r0.x, r0.w, c16.w
mul_pp r2.xy, r2, c18.y
mad r1.z, r1.y, r0.w, c17.x
mul r0.xy, r2, c9.x
abs r1.y, r3
mad r2.y, r1.z, r0.w, c17
dsy r2.zw, r3.xyxz
add r2.x, -r1.y, c14.y
mad r1.z, r1.y, c14, c14.w
mad r1.z, r1, r1.y, c15.x
rsq r2.x, r2.x
mul r2.zw, r2, r2
mad r2.y, r2, r0.w, c17.z
mad r1.y, r1.z, r1, c15
rcp r2.x, r2.x
mul r1.z, r1.y, r2.x
cmp r1.y, r3, c14.x, c14
mul r2.x, r1.y, r1.z
mad r0.w, -r2.x, c15.z, r1.z
mul r1.z, r2.y, r0
mad r0.z, r1.y, c15.w, r0.w
mul r0.w, r0.z, c16.x
add r0.z, r1.x, -r1.w
add r1.y, -r1.z, c17.w
cmp r3.y, -r0.z, r1.z, r1
add r1.x, r2.z, r2.w
dsx r2.xy, r3.xzzw
mul r2.xy, r2, r2
add r0.z, r2.x, r2.y
add r2.w, -r3.y, c15
cmp r2.w, r3.z, r3.y, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r1.x, r1.x
rcp r1.x, r1.x
dsx r1.w, r0
dsy r1.y, r0.w
mul r1.z, r0, c18.x
mul r1.x, r1, c18
texldd r0.xyz, r0, s1, r1.zwzw, r1
add_pp r2.xyz, -r0, c14.y
cmp r2.w, r3.x, r2, -r2
mul r3.y, v0.x, c10.x
mul_sat r3.x, r3.y, c15.z
mad_pp r0.xyz, r3.x, r2, r0
mov r2.y, r0.w
mad r2.x, r2.w, c18, c18.y
texldd r1, r2, s0, r1.zwzw, r1
mul r0.w, v0.x, c8.x
mul r2.x, r0.w, r0.w
mul_sat r4.x, r2, r0.w
add_pp r1.xyz, r1, -r0
mad_pp r1.xyz, r4.x, r1, r0
add r0.xyz, v4, c19.xyyw
texld r0, r0, s2
dp4 r3.w, r0, c20
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
dp4 r2.x, c1, c1
mul r0.x, r0, c2.w
rsq r2.x, r2.x
mul r2.xyz, r2.x, c1
mad r0, -r0.x, c19.z, r3
mov r2.w, c3.x
cmp r0, r0, c14.y, r2.w
dp4_pp r0.y, r0, c19.w
dp3_pp r2.w, v2, -r2
mul_pp r3.xyz, v2, r2.w
mad_pp r3.xyz, -r3, c15.z, -r2
dp3 r0.x, v3, v3
add_pp r4.y, r1.w, c21
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul r2.w, r0.x, r0.y
mul r0.xyz, r2.w, c4
dp3_pp_sat r3.w, r3, v1
mul r3.xyz, r0, c5
pow_pp r0, r3.w, c7.x
dp3_pp_sat r0.w, v2, r2
add_pp r2.x, r0.w, c14.y
frc_pp r2.y, r2.x
add_pp r0.w, r0, c18.z
mul r0.xyz, r3, r0.x
add_pp_sat r2.x, r2, -r2.y
mul r0.xyz, r2.x, r0
mul_pp r0.w, r0, c4
mul r0.xyz, r1.w, r0
mul_pp r1.w, r0, r2
mov r0.w, c11.x
add r2.xyz, c4, r0.w
mad_pp r0.w, r4.x, r4.y, c21.z
mul_pp_sat r1.w, r1, c21.x
mad_sat r2.xyz, r2, r1.w, c0
add_pp r0.xyz, r2, r0
mul_pp r1.xyz, r1, c6
mul r3.xyz, r0, c13.x
mad_sat r2.xyz, r0, c12.x, -r0.w
mad_pp r1.xyz, r1, r2, r3
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r0
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

#LINE 144

	
		}
		
		// Pass to render object as a shadow collector
		Pass {
			Name "ShadowCollector"
			Tags { "LightMode" = "ShadowCollector" }
			
			Fog {Mode Off}
			ZWrite On ZTest LEqual

			Program "vp" {
// Vertex combos: 4
//   opengl - ALU: 24 to 24
//   d3d9 - ALU: 24 to 24
//   d3d11 - ALU: 29 to 29, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 29 to 29, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_2_0
; 24 ALU
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 zFar_3;
  highp vec4 zNear_4;
  bvec4 tmpvar_5;
  tmpvar_5 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_6;
  tmpvar_6 = vec4(tmpvar_5);
  zNear_4 = tmpvar_6;
  bvec4 tmpvar_7;
  tmpvar_7 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(tmpvar_7);
  zFar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (zNear_4 * zFar_3);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((((xlv_TEXCOORD0 * tmpvar_9.x) + (xlv_TEXCOORD1 * tmpvar_9.y)) + (xlv_TEXCOORD2 * tmpvar_9.z)) + (xlv_TEXCOORD3 * tmpvar_9.w));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  highp float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_11.z)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  res_2.x = clamp ((tmpvar_13 + tmpvar_10), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_14.y = tmpvar_15.y;
  enc_14.x = (tmpvar_15.x - (tmpvar_15.y * 0.00392157));
  res_2.zw = enc_14;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 zFar_3;
  highp vec4 zNear_4;
  bvec4 tmpvar_5;
  tmpvar_5 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_6;
  tmpvar_6 = vec4(tmpvar_5);
  zNear_4 = tmpvar_6;
  bvec4 tmpvar_7;
  tmpvar_7 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(tmpvar_7);
  zFar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (zNear_4 * zFar_3);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((((xlv_TEXCOORD0 * tmpvar_9.x) + (xlv_TEXCOORD1 * tmpvar_9.y)) + (xlv_TEXCOORD2 * tmpvar_9.z)) + (xlv_TEXCOORD3 * tmpvar_9.w));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  highp float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_11.z)) {
    tmpvar_13 = _LightShadowData.x;
  } else {
    tmpvar_13 = 1.0;
  };
  res_2.x = clamp ((tmpvar_13 + tmpvar_10), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_14.y = tmpvar_15.y;
  enc_14.x = (tmpvar_15.x - (tmpvar_15.y * 0.00392157));
  res_2.zw = enc_14;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"agal_vs
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.w, a0, c2
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaablaaaaoeabaaaaaa dp4 r1.w, a0, c27
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaabkaaaaoeabaaaaaa dp4 r0.z, a0, c26
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaabiaaaaoeabaaaaaa dp4 r0.x, a0, c24
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaabjaaaaoeabaaaaaa dp4 r0.y, a0, c25
aaaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, r0.xyzz
bfaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r0.w
bdaaaaaaaaaaaeaeabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v0.z, r1, c10
bdaaaaaaaaaaacaeabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v0.y, r1, c9
bdaaaaaaaaaaabaeabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v0.x, r1, c8
bdaaaaaaabaaaeaeabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v1.z, r1, c14
bdaaaaaaabaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v1.y, r1, c13
bdaaaaaaabaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v1.x, r1, c12
bdaaaaaaacaaaeaeabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 v2.z, r1, c18
bdaaaaaaacaaacaeabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 v2.y, r1, c17
bdaaaaaaacaaabaeabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 v2.x, r1, c16
bdaaaaaaadaaaeaeabaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 v3.z, r1, c22
bdaaaaaaadaaacaeabaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 v3.y, r1, c21
bdaaaaaaadaaabaeabaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 v3.x, r1, c20
aaaaaaaaaeaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v4, r0
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 o0.w, a0, c7
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 o0.z, a0, c6
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 o0.y, a0, c5
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, a0, c4
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_2_0
; 24 ALU
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityShadows" 0
BindCB "UnityPerDraw" 1
// 31 instructions, 2 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmnkcbicaflnkacmllblelhfpmpifpejmabaaaaaaeaagaaaaadaaaaaa
cmaaaaaakaaaaaaafiabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoaaeaaaa
eaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaa
abaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaaiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
aaaaaaaabhaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 zFar_4;
  highp vec4 zNear_5;
  bvec4 tmpvar_6;
  tmpvar_6 = greaterThanEqual (xlv_TEXCOORD4.wwww, _LightSplitsNear);
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(tmpvar_6);
  zNear_5 = tmpvar_7;
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (xlv_TEXCOORD4.wwww, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(tmpvar_8);
  zFar_4 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (zNear_5 * zFar_4);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((((xlv_TEXCOORD0 * tmpvar_10.x) + (xlv_TEXCOORD1 * tmpvar_10.y)) + (xlv_TEXCOORD2 * tmpvar_10.z)) + (xlv_TEXCOORD3 * tmpvar_10.w));
  lowp float tmpvar_12;
  tmpvar_12 = shadow2DEXT (_ShadowMapTexture, tmpvar_11.xyz);
  shadow_3 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (shadow_3 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_13;
  res_2.x = clamp ((shadow_3 + clamp (((xlv_TEXCOORD4.w * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_14.y = tmpvar_15.y;
  enc_14.x = (tmpvar_15.x - (tmpvar_15.y * 0.00392157));
  res_2.zw = enc_14;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityShadows" 0
BindCB "UnityPerDraw" 1
// 31 instructions, 2 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefieceddcancklelhchleoiglklmccbijbiodfiabaaaaaapiaiaaaaaeaaaaaa
daaaaaaaoeacaaaammahaaaaeaaiaaaaebgpgodjkmacaaaakmacaaaaaaacpopp
gaacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaiaa
baaaabaaaaaaaaaaabaaaaaaaiaabbaaaaaaaaaaabaaamaaaeaabjaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaabiaaaaaffja
bgaakkkaaeaaaaaeaaaaabiabfaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
bhaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabiaakkkaaaaappjaaaaaaaia
abaaaaacaeaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjabkaaoekaaeaaaaae
aaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiablaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahoaaeaaoekaaaaappia
abaaoeiaafaaaaadabaaahiaaaaaffiaagaaoekaaeaaaaaeabaaahiaafaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaahiaahaaoekaaaaakkiaabaaoeiaaeaaaaae
abaaahoaaiaaoekaaaaappiaabaaoeiaafaaaaadabaaahiaaaaaffiaakaaoeka
aeaaaaaeabaaahiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahiaalaaoeka
aaaakkiaabaaoeiaaeaaaaaeacaaahoaamaaoekaaaaappiaabaaoeiaafaaaaad
abaaahiaaaaaffiaaoaaoekaaeaaaaaeabaaahiaanaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaahiaapaaoekaaaaakkiaabaaoeiaaeaaaaaeadaaahoabaaaoeka
aaaappiaabaaoeiaabaaaaacaeaaahoaaaaaoeiaafaaaaadaaaaapiaaaaaffja
bcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
beaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabgaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaaaaaaaaabhaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

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
#line 316
struct v2f {
    highp vec4 pos;
    highp vec3 _ShadowCoord0;
    highp vec3 _ShadowCoord1;
    highp vec3 _ShadowCoord2;
    highp vec3 _ShadowCoord3;
    highp vec4 _WorldPosViewZ;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 326
#line 339
uniform lowp vec4 _Color;
#line 326
v2f vert( in appdata_base v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 330
    highp vec4 wpos = (_Object2World * v.vertex);
    o._WorldPosViewZ.xyz = vec3( wpos);
    o._WorldPosViewZ.w = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord0 = (unity_World2Shadow[0] * wpos).xyz;
    #line 334
    o._ShadowCoord1 = (unity_World2Shadow[1] * wpos).xyz;
    o._ShadowCoord2 = (unity_World2Shadow[2] * wpos).xyz;
    o._ShadowCoord3 = (unity_World2Shadow[3] * wpos).xyz;
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval._ShadowCoord0);
    xlv_TEXCOORD1 = vec3(xl_retval._ShadowCoord1);
    xlv_TEXCOORD2 = vec3(xl_retval._ShadowCoord2);
    xlv_TEXCOORD3 = vec3(xl_retval._ShadowCoord3);
    xlv_TEXCOORD4 = vec4(xl_retval._WorldPosViewZ);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
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
#line 316
struct v2f {
    highp vec4 pos;
    highp vec3 _ShadowCoord0;
    highp vec3 _ShadowCoord1;
    highp vec3 _ShadowCoord2;
    highp vec3 _ShadowCoord3;
    highp vec4 _WorldPosViewZ;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 326
#line 339
uniform lowp vec4 _Color;
#line 220
highp vec2 EncodeFloatRG( in highp float v ) {
    highp vec2 kEncodeMul = vec2( 1.0, 255.0);
    highp float kEncodeBit = 0.00392157;
    #line 224
    highp vec2 enc = (kEncodeMul * v);
    enc = fract(enc);
    enc.x -= (enc.y * kEncodeBit);
    return enc;
}
#line 340
lowp vec4 frag( in v2f i ) {
    highp vec4 viewZ = vec4( i._WorldPosViewZ.w);
    #line 343
    highp vec4 zNear = vec4(greaterThanEqual( viewZ, _LightSplitsNear));
    highp vec4 zFar = vec4(lessThan( viewZ, _LightSplitsFar));
    highp vec4 cascadeWeights = (zNear * zFar);
    highp float shadowFade = xll_saturate_f(((i._WorldPosViewZ.w * _LightShadowData.z) + _LightShadowData.w));
    #line 347
    highp vec4 coord = vec4( ((((i._ShadowCoord0 * cascadeWeights.x) + (i._ShadowCoord1 * cascadeWeights.y)) + (i._ShadowCoord2 * cascadeWeights.z)) + (i._ShadowCoord3 * cascadeWeights.w)), 1.0);
    mediump float shadow = xll_shadow2D( _ShadowMapTexture, coord.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    highp vec4 res;
    #line 351
    res.x = xll_saturate_f((shadow + shadowFade));
    res.y = 1.0;
    res.zw = EncodeFloatRG( (1.0 - (i._WorldPosViewZ.w * _ProjectionParams.w)));
    return res;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i._ShadowCoord0 = vec3(xlv_TEXCOORD0);
    xlt_i._ShadowCoord1 = vec3(xlv_TEXCOORD1);
    xlt_i._ShadowCoord2 = vec3(xlv_TEXCOORD2);
    xlt_i._ShadowCoord3 = vec3(xlv_TEXCOORD3);
    xlt_i._WorldPosViewZ = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_2_0
; 24 ALU
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 cascadeWeights_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_4, tmpvar_4);
  tmpvar_8.y = dot (tmpvar_5, tmpvar_5);
  tmpvar_8.z = dot (tmpvar_6, tmpvar_6);
  tmpvar_8.w = dot (tmpvar_7, tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (tmpvar_8, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_10;
  tmpvar_10 = vec4(tmpvar_9);
  cascadeWeights_3 = tmpvar_10;
  cascadeWeights_3.yzw = clamp ((cascadeWeights_3.yzw - cascadeWeights_3.xyz), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((sqrt(dot (p_11, p_11)) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((((xlv_TEXCOORD0 * cascadeWeights_3.x) + (xlv_TEXCOORD1 * cascadeWeights_3.y)) + (xlv_TEXCOORD2 * cascadeWeights_3.z)) + (xlv_TEXCOORD3 * cascadeWeights_3.w));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_13.z)) {
    tmpvar_15 = _LightShadowData.x;
  } else {
    tmpvar_15 = 1.0;
  };
  res_2.x = clamp ((tmpvar_15 + tmpvar_12), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp vec4 cascadeWeights_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_4, tmpvar_4);
  tmpvar_8.y = dot (tmpvar_5, tmpvar_5);
  tmpvar_8.z = dot (tmpvar_6, tmpvar_6);
  tmpvar_8.w = dot (tmpvar_7, tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = lessThan (tmpvar_8, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_10;
  tmpvar_10 = vec4(tmpvar_9);
  cascadeWeights_3 = tmpvar_10;
  cascadeWeights_3.yzw = clamp ((cascadeWeights_3.yzw - cascadeWeights_3.xyz), 0.0, 1.0);
  highp vec3 p_11;
  p_11 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((sqrt(dot (p_11, p_11)) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((((xlv_TEXCOORD0 * cascadeWeights_3.x) + (xlv_TEXCOORD1 * cascadeWeights_3.y)) + (xlv_TEXCOORD2 * cascadeWeights_3.z)) + (xlv_TEXCOORD3 * cascadeWeights_3.w));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_13.z)) {
    tmpvar_15 = _LightShadowData.x;
  } else {
    tmpvar_15 = 1.0;
  };
  res_2.x = clamp ((tmpvar_15 + tmpvar_12), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"agal_vs
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.w, a0, c2
bdaaaaaaabaaaiacaaaaaaoeaaaaaaaablaaaaoeabaaaaaa dp4 r1.w, a0, c27
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaabkaaaaoeabaaaaaa dp4 r0.z, a0, c26
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaabiaaaaoeabaaaaaa dp4 r0.x, a0, c24
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaabjaaaaoeabaaaaaa dp4 r0.y, a0, c25
aaaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, r0.xyzz
bfaaaaaaaaaaaiacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa neg r0.w, r0.w
bdaaaaaaaaaaaeaeabaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v0.z, r1, c10
bdaaaaaaaaaaacaeabaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v0.y, r1, c9
bdaaaaaaaaaaabaeabaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v0.x, r1, c8
bdaaaaaaabaaaeaeabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 v1.z, r1, c14
bdaaaaaaabaaacaeabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 v1.y, r1, c13
bdaaaaaaabaaabaeabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 v1.x, r1, c12
bdaaaaaaacaaaeaeabaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 v2.z, r1, c18
bdaaaaaaacaaacaeabaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 v2.y, r1, c17
bdaaaaaaacaaabaeabaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 v2.x, r1, c16
bdaaaaaaadaaaeaeabaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 v3.z, r1, c22
bdaaaaaaadaaacaeabaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 v3.y, r1, c21
bdaaaaaaadaaabaeabaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 v3.x, r1, c20
aaaaaaaaaeaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v4, r0
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 o0.w, a0, c7
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 o0.z, a0, c6
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 o0.y, a0, c5
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 o0.x, a0, c4
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Matrix 9 [unity_World2Shadow0]
Matrix 13 [unity_World2Shadow1]
Matrix 17 [unity_World2Shadow2]
Matrix 21 [unity_World2Shadow3]
Matrix 25 [_Object2World]
"!!ARBvp1.0
# 24 ALU
PARAM c[29] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..28] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[28];
DP4 R0.z, vertex.position, c[27];
DP4 R0.x, vertex.position, c[25];
DP4 R0.y, vertex.position, c[26];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[11];
DP4 result.texcoord[0].y, R1, c[10];
DP4 result.texcoord[0].x, R1, c[9];
DP4 result.texcoord[1].z, R1, c[15];
DP4 result.texcoord[1].y, R1, c[14];
DP4 result.texcoord[1].x, R1, c[13];
DP4 result.texcoord[2].z, R1, c[19];
DP4 result.texcoord[2].y, R1, c[18];
DP4 result.texcoord[2].x, R1, c[17];
DP4 result.texcoord[3].z, R1, c[23];
DP4 result.texcoord[3].y, R1, c[22];
DP4 result.texcoord[3].x, R1, c[21];
MOV result.texcoord[4], R0;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 24 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [unity_World2Shadow0]
Matrix 12 [unity_World2Shadow1]
Matrix 16 [unity_World2Shadow2]
Matrix 20 [unity_World2Shadow3]
Matrix 24 [_Object2World]
"vs_2_0
; 24 ALU
dcl_position0 v0
dp4 r0.w, v0, c2
dp4 r1.w, v0, c27
dp4 r0.z, v0, c26
dp4 r0.x, v0, c24
dp4 r0.y, v0, c25
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c10
dp4 oT0.y, r1, c9
dp4 oT0.x, r1, c8
dp4 oT1.z, r1, c14
dp4 oT1.y, r1, c13
dp4 oT1.x, r1, c12
dp4 oT2.z, r1, c18
dp4 oT2.y, r1, c17
dp4 oT2.x, r1, c16
dp4 oT3.z, r1, c22
dp4 oT3.y, r1, c21
dp4 oT3.x, r1, c20
mov oT4, r0
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityShadows" 0
BindCB "UnityPerDraw" 1
// 31 instructions, 2 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmnkcbicaflnkacmllblelhfpmpifpejmabaaaaaaeaagaaaaadaaaaaa
cmaaaaaakaaaaaaafiabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoaaeaaaa
eaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaa
abaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaaiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaabfaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabeaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
aaaaaaaabhaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaa
afaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = tmpvar_2.xyz;
  tmpvar_1.w = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (unity_World2Shadow[0] * tmpvar_2).xyz;
  xlv_TEXCOORD1 = (unity_World2Shadow[1] * tmpvar_2).xyz;
  xlv_TEXCOORD2 = (unity_World2Shadow[2] * tmpvar_2).xyz;
  xlv_TEXCOORD3 = (unity_World2Shadow[3] * tmpvar_2).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 _ProjectionParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  mediump float shadow_3;
  highp vec4 cascadeWeights_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD4.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.x = dot (tmpvar_5, tmpvar_5);
  tmpvar_9.y = dot (tmpvar_6, tmpvar_6);
  tmpvar_9.z = dot (tmpvar_7, tmpvar_7);
  tmpvar_9.w = dot (tmpvar_8, tmpvar_8);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (tmpvar_9, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_11;
  tmpvar_11 = vec4(tmpvar_10);
  cascadeWeights_4 = tmpvar_11;
  cascadeWeights_4.yzw = clamp ((cascadeWeights_4.yzw - cascadeWeights_4.xyz), 0.0, 1.0);
  highp vec3 p_12;
  p_12 = (xlv_TEXCOORD4.xyz - unity_ShadowFadeCenterAndType.xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((((xlv_TEXCOORD0 * cascadeWeights_4.x) + (xlv_TEXCOORD1 * cascadeWeights_4.y)) + (xlv_TEXCOORD2 * cascadeWeights_4.z)) + (xlv_TEXCOORD3 * cascadeWeights_4.w));
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, tmpvar_13.xyz);
  shadow_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (shadow_3 * (1.0 - _LightShadowData.x)));
  shadow_3 = tmpvar_15;
  res_2.x = clamp ((shadow_3 + clamp (((sqrt(dot (p_12, p_12)) * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  res_2.y = 1.0;
  highp vec2 enc_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = fract((vec2(1.0, 255.0) * (1.0 - (xlv_TEXCOORD4.w * _ProjectionParams.w))));
  enc_16.y = tmpvar_17.y;
  enc_16.x = (tmpvar_17.x - (tmpvar_17.y * 0.00392157));
  res_2.zw = enc_16;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Bind "vertex" Vertex
ConstBuffer "UnityShadows" 416 // 384 used size, 8 vars
Matrix 128 [unity_World2Shadow0] 4
Matrix 192 [unity_World2Shadow1] 4
Matrix 256 [unity_World2Shadow2] 4
Matrix 320 [unity_World2Shadow3] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "UnityShadows" 0
BindCB "UnityPerDraw" 1
// 31 instructions, 2 temp regs, 0 temp arrays:
// ALU 29 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefieceddcancklelhchleoiglklmccbijbiodfiabaaaaaapiaiaaaaaeaaaaaa
daaaaaaaoeacaaaammahaaaaeaaiaaaaebgpgodjkmacaaaakmacaaaaaaacpopp
gaacaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaiaa
baaaabaaaaaaaaaaabaaaaaaaiaabbaaaaaaaaaaabaaamaaaeaabjaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaabiaaaaaffja
bgaakkkaaeaaaaaeaaaaabiabfaakkkaaaaaaajaaaaaaaiaaeaaaaaeaaaaabia
bhaakkkaaaaakkjaaaaaaaiaaeaaaaaeaaaaabiabiaakkkaaaaappjaaaaaaaia
abaaaaacaeaaaioaaaaaaaibafaaaaadaaaaapiaaaaaffjabkaaoekaaeaaaaae
aaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiablaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahoaaeaaoekaaaaappia
abaaoeiaafaaaaadabaaahiaaaaaffiaagaaoekaaeaaaaaeabaaahiaafaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaahiaahaaoekaaaaakkiaabaaoeiaaeaaaaae
abaaahoaaiaaoekaaaaappiaabaaoeiaafaaaaadabaaahiaaaaaffiaakaaoeka
aeaaaaaeabaaahiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaahiaalaaoeka
aaaakkiaabaaoeiaaeaaaaaeacaaahoaamaaoekaaaaappiaabaaoeiaafaaaaad
abaaahiaaaaaffiaaoaaoekaaeaaaaaeabaaahiaanaaoekaaaaaaaiaabaaoeia
aeaaaaaeabaaahiaapaaoekaaaaakkiaabaaoeiaaeaaaaaeadaaahoabaaaoeka
aaaappiaabaaoeiaabaaaaacaeaaahoaaaaaoeiaafaaaaadaaaaapiaaaaaffja
bcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaabaaaaaa
egiccaaaaaaaaaaaalaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaabcaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaabdaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabfaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
beaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabgaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaaaaaaaaabhaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaabaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagiccabaaaafaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

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
#line 316
struct v2f {
    highp vec4 pos;
    highp vec3 _ShadowCoord0;
    highp vec3 _ShadowCoord1;
    highp vec3 _ShadowCoord2;
    highp vec3 _ShadowCoord3;
    highp vec4 _WorldPosViewZ;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 326
#line 339
uniform lowp vec4 _Color;
#line 326
v2f vert( in appdata_base v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 330
    highp vec4 wpos = (_Object2World * v.vertex);
    o._WorldPosViewZ.xyz = vec3( wpos);
    o._WorldPosViewZ.w = (-(glstate_matrix_modelview0 * v.vertex).z);
    o._ShadowCoord0 = (unity_World2Shadow[0] * wpos).xyz;
    #line 334
    o._ShadowCoord1 = (unity_World2Shadow[1] * wpos).xyz;
    o._ShadowCoord2 = (unity_World2Shadow[2] * wpos).xyz;
    o._ShadowCoord3 = (unity_World2Shadow[3] * wpos).xyz;
    return o;
}
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval._ShadowCoord0);
    xlv_TEXCOORD1 = vec3(xl_retval._ShadowCoord1);
    xlv_TEXCOORD2 = vec3(xl_retval._ShadowCoord2);
    xlv_TEXCOORD3 = vec3(xl_retval._ShadowCoord3);
    xlv_TEXCOORD4 = vec4(xl_retval._WorldPosViewZ);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
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
#line 316
struct v2f {
    highp vec4 pos;
    highp vec3 _ShadowCoord0;
    highp vec3 _ShadowCoord1;
    highp vec3 _ShadowCoord2;
    highp vec3 _ShadowCoord3;
    highp vec4 _WorldPosViewZ;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 326
#line 339
uniform lowp vec4 _Color;
#line 220
highp vec2 EncodeFloatRG( in highp float v ) {
    highp vec2 kEncodeMul = vec2( 1.0, 255.0);
    highp float kEncodeBit = 0.00392157;
    #line 224
    highp vec2 enc = (kEncodeMul * v);
    enc = fract(enc);
    enc.x -= (enc.y * kEncodeBit);
    return enc;
}
#line 340
lowp vec4 frag( in v2f i ) {
    highp vec3 fromCenter0 = (i._WorldPosViewZ.xyz - unity_ShadowSplitSpheres[0].xyz);
    #line 343
    highp vec3 fromCenter1 = (i._WorldPosViewZ.xyz - unity_ShadowSplitSpheres[1].xyz);
    highp vec3 fromCenter2 = (i._WorldPosViewZ.xyz - unity_ShadowSplitSpheres[2].xyz);
    highp vec3 fromCenter3 = (i._WorldPosViewZ.xyz - unity_ShadowSplitSpheres[3].xyz);
    highp vec4 distances2 = vec4( dot( fromCenter0, fromCenter0), dot( fromCenter1, fromCenter1), dot( fromCenter2, fromCenter2), dot( fromCenter3, fromCenter3));
    #line 347
    highp vec4 cascadeWeights = vec4(lessThan( distances2, unity_ShadowSplitSqRadii));
    cascadeWeights.yzw = xll_saturate_vf3((cascadeWeights.yzw - cascadeWeights.xyz));
    highp float sphereDist = distance( i._WorldPosViewZ.xyz, unity_ShadowFadeCenterAndType.xyz);
    highp float shadowFade = xll_saturate_f(((sphereDist * _LightShadowData.z) + _LightShadowData.w));
    #line 351
    highp vec4 coord = vec4( ((((i._ShadowCoord0 * cascadeWeights.x) + (i._ShadowCoord1 * cascadeWeights.y)) + (i._ShadowCoord2 * cascadeWeights.z)) + (i._ShadowCoord3 * cascadeWeights.w)), 1.0);
    mediump float shadow = xll_shadow2D( _ShadowMapTexture, coord.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    highp vec4 res;
    #line 355
    res.x = xll_saturate_f((shadow + shadowFade));
    res.y = 1.0;
    res.zw = EncodeFloatRG( (1.0 - (i._WorldPosViewZ.w * _ProjectionParams.w)));
    return res;
}
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i._ShadowCoord0 = vec3(xlv_TEXCOORD0);
    xlt_i._ShadowCoord1 = vec3(xlv_TEXCOORD1);
    xlt_i._ShadowCoord2 = vec3(xlv_TEXCOORD2);
    xlt_i._ShadowCoord3 = vec3(xlv_TEXCOORD3);
    xlt_i._WorldPosViewZ = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 4
//   opengl - ALU: 21 to 32, TEX: 1 to 1
//   d3d9 - ALU: 24 to 37, TEX: 1 to 1
//   d3d11 - ALU: 17 to 27, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 17 to 27, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
SLT R1, fragment.texcoord[4].w, c[2];
SGE R0, fragment.texcoord[4].w, c[1];
MUL R0, R0, R1;
MUL R1.xyz, R0.y, fragment.texcoord[1];
MAD R1.xyz, R0.x, fragment.texcoord[0], R1;
MAD R0.xyz, R0.z, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.w, R0;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV result.color.y, c[4].x;
TEX R0.x, R0, texture[0], 2D;
ADD R0.z, R0.x, -R0;
MOV R0.x, c[4];
CMP R1.x, R0.z, c[3], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[4].x;
MUL R0.xy, R0.y, c[4];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[4].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 26 ALU, 1 TEX
dcl_2d s0
def c4, 1.00000000, 0.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
add r1, t4.w, -c2
add r0, t4.w, -c1
cmp r1, r1, c4.y, c4.x
cmp r0, r0, c4.x, c4.y
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r0.xyz, r0.z, t2, r1
mad r1.xyz, t3, r0.w, r0
mov r2.x, c3
mov r2.y, c4.z
texld r0, r1, s0
add r0.x, r0, -r1.z
cmp r0.x, r0, c4, r2
mul r1.x, -t4.w, c0.w
add r1.x, r1, c4
mov r2.x, c4
mul r2.xy, r1.x, r2
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c4.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c4.x
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 0 [_ShadowMapTexture] 2D
"agal_ps
c4 1.0 0.0 255.0 0.003922
c5 1.0 0.003922 0.000015 0.0
[bc]
acaaaaaaabaaapacaeaaaappaeaaaaaaacaaaaoeabaaaaaa sub r1, v4.w, c2
acaaaaaaaaaaapacaeaaaappaeaaaaaaabaaaaoeabaaaaaa sub r0, v4.w, c1
ckaaaaaaacaaapacabaaaaoeacaaaaaaaeaaaaffabaaaaaa slt r2, r1, c4.y
aaaaaaaaadaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r3, c4
aaaaaaaaaeaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c4
acaaaaaaaeaaapacadaaaaaaacaaaaaaaeaaaaffacaaaaaa sub r4, r3.x, r4.y
adaaaaaaabaaapacaeaaaaoeacaaaaaaacaaaaoeacaaaaaa mul r1, r4, r2
abaaaaaaabaaapacabaaaaoeacaaaaaaaeaaaaffabaaaaaa add r1, r1, c4.y
ckaaaaaaaeaaapacaaaaaaoeacaaaaaaaeaaaaffabaaaaaa slt r4, r0, c4.y
aaaaaaaaafaaacacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r5.y, c4
aaaaaaaaafaaapacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r5, c4
acaaaaaaadaaapacafaaaaffacaaaaaaafaaaaaaacaaaaaa sub r3, r5.y, r5.x
adaaaaaaaaaaapacadaaaaoeacaaaaaaaeaaaaoeacaaaaaa mul r0, r3, r4
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaeaaaaaaabaaaaaa add r0, r0, c4.x
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaabaaaaoeaeaaaaaa mul r1.xyz, r0.y, v1
adaaaaaaaeaaahacaaaaaaaaacaaaaaaaaaaaaoeaeaaaaaa mul r4.xyz, r0.x, v0
abaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaaacaaaaoeaeaaaaaa mul r0.xyz, r0.z, v2
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacadaaaaoeaeaaaaaaaaaaaappacaaaaaa mul r1.xyz, v3, r0.w
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
aaaaaaaaacaaabacadaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c3
aaaaaaaaacaaacacaeaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c4.z
ciaaaaaaaaaaapacabaaaafeacaaaaaaaaaaaaaaafaababb tex r0, r1.xyyy, s0 <2d wrap linear point>
bdaaaaaaaaaaabacaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 r0.x, r0, c5
acaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaakkacaaaaaa sub r0.x, r0.x, r1.z
ckaaaaaaadaaabacaaaaaaaaacaaaaaaaeaaaaffabaaaaaa slt r3.x, r0.x, c4.y
acaaaaaaaeaaabacacaaaaaaacaaaaaaaeaaaaoeabaaaaaa sub r4.x, r2.x, c4
adaaaaaaaaaaabacaeaaaaaaacaaaaaaadaaaaaaacaaaaaa mul r0.x, r4.x, r3.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaoeabaaaaaa add r0.x, r0.x, c4
bfaaaaaaadaaaiacaeaaaappaeaaaaaaaaaaaaaaaaaaaaaa neg r3.w, v4.w
adaaaaaaabaaabacadaaaappacaaaaaaaaaaaappabaaaaaa mul r1.x, r3.w, c0.w
abaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaaoeabaaaaaa add r1.x, r1.x, c4
aaaaaaaaacaaabacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.x, c4
adaaaaaaacaaadacabaaaaaaacaaaaaaacaaaafeacaaaaaa mul r2.xy, r1.x, r2.xyyy
adaaaaaaabaaabacaeaaaappaeaaaaaaadaaaakkabaaaaaa mul r1.x, v4.w, c3.z
abaaaaaaabaaabacabaaaaaaacaaaaaaadaaaappabaaaaaa add r1.x, r1.x, c3.w
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
aiaaaaaaacaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa frc r2.xy, r2.xyyy
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaaaacaaaaaa add r0.x, r0.x, r1.x
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bfaaaaaaaeaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r4.y, r2.y
adaaaaaaabaaabacaeaaaaffacaaaaaaaeaaaappabaaaaaa mul r1.x, r4.y, c4.w
abaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaaaacaaaaaa add r1.x, r1.x, r2.x
aaaaaaaaaaaaaiacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.y
aaaaaaaaaaaaaeacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r1.x
aaaaaaaaaaaaacacaeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.y, c4.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 1 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[5] = { program.local[0..3],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
SLT R1, fragment.texcoord[4].w, c[2];
SGE R0, fragment.texcoord[4].w, c[1];
MUL R0, R0, R1;
MUL R1.xyz, R0.y, fragment.texcoord[1];
MAD R1.xyz, R0.x, fragment.texcoord[0], R1;
MAD R0.xyz, R0.z, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.w, R0;
MAD_SAT R1.y, fragment.texcoord[4].w, c[3].z, c[3].w;
MOV result.color.y, c[4].x;
TEX R0.x, R0, texture[0], SHADOW2D;
MOV R0.y, c[4].x;
ADD R0.w, R0.y, -c[3].x;
MAD R1.x, R0, R0.w, c[3];
MUL R0.z, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0.z, c[4].x;
MUL R0.xy, R0.y, c[4];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[4].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightSplitsNear]
Vector 2 [_LightSplitsFar]
Vector 3 [_LightShadowData]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 24 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
add r1, t4.w, -c2
add r0, t4.w, -c1
cmp r1, r1, c4.x, c4.y
cmp r0, r0, c4.y, c4.x
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r0.xyz, r0.z, t2, r1
mad r0.xyz, t3, r0.w, r0
mul r1.x, -t4.w, c0.w
add r1.x, r1, c4.y
texld r2, r0, s0
mov r0.x, c3
add r0.x, c4.y, -r0
mad r0.x, r2, r0, c3
mul r2.xy, r1.x, c4.yzxw
mad_sat r1.x, t4.w, c3.z, c3.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c4.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c4
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" }
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 96 [_LightSplitsNear] 4
Vector 112 [_LightSplitsFar] 4
Vector 384 [_LightShadowData] 4
BindCB "UnityPerCamera" 0
BindCB "UnityShadows" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 2 uint
// TEX 0 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfoicichoepiaaopfmpilgmkjgoeglgdgabaaaaaageaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeadaaaa
eaaaaaaanbaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadicbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabnaaaaaipcaabaaaaaaaaaaa
pgbpbaaaafaaaaaaegiocaaaabaaaaaaagaaaaaaabaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdbaaaaai
pcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaabaaaaaaahaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaa
aaaaaaaaaagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
akiacaiaebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaa
dccaaaalccaabaaaaaaaaaaadkbabaaaafaaaaaackiacaaaabaaaaaabiaaaaaa
dkiacaaaabaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaiaebaaaaaaafaaaaaa
dkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaakdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaaaaaaaaaabkaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}

SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" }
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 400 used size, 8 vars
Vector 96 [_LightSplitsNear] 4
Vector 112 [_LightSplitsFar] 4
Vector 384 [_LightShadowData] 4
BindCB "UnityPerCamera" 0
BindCB "UnityShadows" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 21 instructions, 2 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 2 uint
// TEX 0 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedphcelgomhcehbhmgdplfpphjcngdocfgabaaaaaaiiagaaaaafaaaaaa
deaaaaaaeaacaaaaimafaaaajmafaaaafeagaaaaebgpgodjaeacaaaaaeacaaaa
aaacppppliabaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaa
aaaaaaaaaaaaafaaabaaaaaaaaaaaaaaabaaagaaacaaabaaaaaaaaaaabaabiaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaaaaaaiadpaaaahped
ibiaiadlbpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaapiaaeaapplaacaaoekbfiaaaaae
aaaaapiaaaaaoeiaaeaaaakaaeaaffkaacaaaaadabaaapiaaeaapplaabaaoekb
fiaaaaaeaaaaapiaabaaoeiaaaaaoeiaaeaaaakaafaaaaadabaaahiaaaaaffia
abaaoelaaeaaaaaeabaaahiaaaaaoelaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
acaaoelaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaadaaoelaaaaappiaaaaaoeia
ecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaaaciaaeaaffkabcaaaaae
abaacbiaaaaaaaiaaaaaffiaadaaaakaaeaaaaaeaaaabbiaaeaapplaadaakkka
adaappkaacaaaaadabaadbiaaaaaaaiaabaaaaiaaeaaaaaeaaaaabiaaeaappla
aaaappkbaaaaffiaafaaaaadaaaaadiaaaaaaaiaaeaamjkabdaaaaacaaaaadia
aaaaoeiaaeaaaaaeabaaceiaaaaaffiaaeaappkbaaaaaaiaabaaaaacabaaciia
aaaaffiaabaaaaacabaaaciaaeaaffkaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefceeadaaaaeaaaaaaanbaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fjaaaaaeegiocaaaabaaaaaabjaaaaaafkaiaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
icbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabnaaaaai
pcaabaaaaaaaaaaapgbpbaaaafaaaaaaegiocaaaabaaaaaaagaaaaaaabaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdbaaaaaipcaabaaaabaaaaaapgbpbaaaafaaaaaaegiocaaaabaaaaaa
ahaaaaaaabaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaghabaaaaaaaaaaaaagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadp
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaabiaaaaaadccaaaalccaabaaaaaaaaaaadkbabaaaafaaaaaackiacaaa
abaaaaaabiaaaaaadkiacaaaabaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaia
ebaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaak
dcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaa
aaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaaiaaaaaaaaaaaaaaaejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 1 TEX
PARAM c[9] = { program.local[0..7],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
ADD R0.xyz, fragment.texcoord[4], -c[1];
ADD R2.xyz, fragment.texcoord[4], -c[4];
DP3 R0.x, R0, R0;
ADD R1.xyz, fragment.texcoord[4], -c[2];
DP3 R0.y, R1, R1;
ADD R1.xyz, fragment.texcoord[4], -c[3];
DP3 R0.w, R2, R2;
DP3 R0.z, R1, R1;
SLT R2, R0, c[5];
ADD_SAT R0.xyz, R2.yzww, -R2;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R2.x, fragment.texcoord[0], R1;
MAD R1.xyz, R0.y, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.z, R1;
ADD R1.xyz, -fragment.texcoord[4], c[7];
MOV result.color.y, c[8].x;
TEX R0.x, R0, texture[0], 2D;
ADD R0.y, R0.x, -R0.z;
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MOV R0.x, c[8];
CMP R0.x, R0.y, c[6], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[8].x;
RCP R1.x, R0.z;
MUL R0.zw, R0.y, c[8].xyxy;
MAD_SAT R0.y, R1.x, c[6].z, c[6].w;
FRC R0.zw, R0;
ADD_SAT result.color.x, R0, R0.y;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[8].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 32 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 37 ALU, 1 TEX
dcl_2d s0
def c8, 1.00000000, 255.00000000, 0.00392157, 0.00000000
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
add r0.xyz, t4, -c1
add r2.xyz, t4, -c4
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
dp3 r0.w, r2, r2
add r0, r0, -c5
cmp r0, r0, c8.w, c8.x
mov r1.x, r0.y
mov r1.z, r0.w
mov r1.y, r0.z
add_sat r1.xyz, r1, -r0
mul r2.xyz, r1.x, t1
mad r0.xyz, r0.x, t0, r2
mad r0.xyz, r1.y, t2, r0
mad r1.xyz, t3, r1.z, r0
add r2.xyz, -t4, c7
texld r0, r1, s0
mov r1.x, c6
add r0.x, r0, -r1.z
cmp r0.x, r0, c8, r1
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c8
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
mul r2.xy, r2.x, c8
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c8.z, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c8.x
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SHADOWS_NONATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_ShadowMapTexture] 2D
"agal_ps
c8 1.0 255.0 0.003922 0.0
c9 1.0 0.003922 0.000015 0.0
[bc]
acaaaaaaaaaaahacaeaaaaoeaeaaaaaaabaaaaoeabaaaaaa sub r0.xyz, v4, c1
acaaaaaaacaaahacaeaaaaoeaeaaaaaaaeaaaaoeabaaaaaa sub r2.xyz, v4, c4
bcaaaaaaaaaaabacaaaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r0.x, r0.xyzz, r0.xyzz
acaaaaaaabaaahacaeaaaaoeaeaaaaaaacaaaaoeabaaaaaa sub r1.xyz, v4, c2
bcaaaaaaaaaaacacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.y, r1.xyzz, r1.xyzz
acaaaaaaabaaahacaeaaaaoeaeaaaaaaadaaaaoeabaaaaaa sub r1.xyz, v4, c3
bcaaaaaaaaaaaeacabaaaakeacaaaaaaabaaaakeacaaaaaa dp3 r0.z, r1.xyzz, r1.xyzz
bcaaaaaaaaaaaiacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r0.w, r2.xyzz, r2.xyzz
acaaaaaaaaaaapacaaaaaaoeacaaaaaaafaaaaoeabaaaaaa sub r0, r0, c5
ckaaaaaaadaaapacaaaaaaoeacaaaaaaaiaaaappabaaaaaa slt r3, r0, c8.w
aaaaaaaaaeaaapacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r4, c8
aaaaaaaaabaaaiacaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.w, c8
acaaaaaaaeaaapacaeaaaaaaacaaaaaaabaaaappacaaaaaa sub r4, r4.x, r1.w
adaaaaaaaaaaapacaeaaaaoeacaaaaaaadaaaaoeacaaaaaa mul r0, r4, r3
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaiaaaappabaaaaaa add r0, r0, c8.w
aaaaaaaaabaaabacaaaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r0.y
aaaaaaaaabaaaeacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r1.z, r0.w
aaaaaaaaabaaacacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r0.z
acaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa sub r1.xyz, r1.xyzz, r0.xyzz
bgaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaaaaaaaaaaa sat r1.xyz, r1.xyzz
adaaaaaaacaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r2.xyz, r1.x, v1
adaaaaaaaaaaahacaaaaaaaaacaaaaaaaaaaaaoeaeaaaaaa mul r0.xyz, r0.x, v0
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaadaaahacabaaaaffacaaaaaaacaaaaoeaeaaaaaa mul r3.xyz, r1.y, v2
abaaaaaaaaaaahacadaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r3.xyzz, r0.xyzz
adaaaaaaabaaahacadaaaaoeaeaaaaaaabaaaakkacaaaaaa mul r1.xyz, v3, r1.z
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
bfaaaaaaacaaahacaeaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa neg r2.xyz, v4
abaaaaaaacaaahacacaaaakeacaaaaaaahaaaaoeabaaaaaa add r2.xyz, r2.xyzz, c7
ciaaaaaaaaaaapacabaaaafeacaaaaaaaaaaaaaaafaababb tex r0, r1.xyyy, s0 <2d wrap linear point>
bdaaaaaaaaaaabacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r0.x, r0, c9
aaaaaaaaabaaabacagaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.x, c6
acaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaakkacaaaaaa sub r0.x, r0.x, r1.z
ckaaaaaaaeaaabacaaaaaaaaacaaaaaaaiaaaappabaaaaaa slt r4.x, r0.x, c8.w
acaaaaaaadaaabacabaaaaaaacaaaaaaaiaaaaoeabaaaaaa sub r3.x, r1.x, c8
adaaaaaaaaaaabacadaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r3.x, r4.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaiaaaaoeabaaaaaa add r0.x, r0.x, c8
bcaaaaaaabaaabacacaaaakeacaaaaaaacaaaakeacaaaaaa dp3 r1.x, r2.xyzz, r2.xyzz
bfaaaaaaaeaaaiacaeaaaappaeaaaaaaaaaaaaaaaaaaaaaa neg r4.w, v4.w
adaaaaaaacaaabacaeaaaappacaaaaaaaaaaaappabaaaaaa mul r2.x, r4.w, c0.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
abaaaaaaacaaabacacaaaaaaacaaaaaaaiaaaaoeabaaaaaa add r2.x, r2.x, c8
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
adaaaaaaabaaabacabaaaaaaacaaaaaaagaaaakkabaaaaaa mul r1.x, r1.x, c6.z
abaaaaaaabaaabacabaaaaaaacaaaaaaagaaaappabaaaaaa add r1.x, r1.x, c6.w
bgaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r1.x, r1.x
adaaaaaaacaaadacacaaaaaaacaaaaaaaiaaaaoeabaaaaaa mul r2.xy, r2.x, c8
aiaaaaaaacaaadacacaaaafeacaaaaaaaaaaaaaaaaaaaaaa frc r2.xy, r2.xyyy
abaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaaaacaaaaaa add r0.x, r0.x, r1.x
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
aaaaaaaaabaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.y
bfaaaaaaadaaacacacaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r3.y, r2.y
adaaaaaaabaaabacadaaaaffacaaaaaaaiaaaakkabaaaaaa mul r1.x, r3.y, c8.z
abaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaaaacaaaaaa add r1.x, r1.x, r2.x
aaaaaaaaaaaaaiacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.y
aaaaaaaaaaaaaeacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r1.x
aaaaaaaaaaaaacacaiaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.y, c8.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 1 TEX
OPTION ARB_fragment_program_shadow;
PARAM c[9] = { program.local[0..7],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
ADD R0.xyz, fragment.texcoord[4], -c[1];
ADD R2.xyz, fragment.texcoord[4], -c[4];
DP3 R0.x, R0, R0;
ADD R1.xyz, fragment.texcoord[4], -c[2];
DP3 R0.y, R1, R1;
ADD R1.xyz, fragment.texcoord[4], -c[3];
DP3 R0.w, R2, R2;
DP3 R0.z, R1, R1;
SLT R2, R0, c[5];
ADD_SAT R0.xyz, R2.yzww, -R2;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R2.x, fragment.texcoord[0], R1;
MAD R1.xyz, R0.y, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.z, R1;
ADD R1.xyz, -fragment.texcoord[4], c[7];
MOV result.color.y, c[8].x;
TEX R0.x, R0, texture[0], SHADOW2D;
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MOV R0.y, c[8].x;
ADD R0.y, R0, -c[6].x;
MAD R0.x, R0, R0.y, c[6];
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[8].x;
RCP R1.x, R0.z;
MUL R0.zw, R0.y, c[8].xyxy;
MAD_SAT R0.y, R1.x, c[6].z, c[6].w;
FRC R0.zw, R0;
ADD_SAT result.color.x, R0, R0.y;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[8].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 32 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
Vector 0 [_ProjectionParams]
Vector 1 [unity_ShadowSplitSpheres0]
Vector 2 [unity_ShadowSplitSpheres1]
Vector 3 [unity_ShadowSplitSpheres2]
Vector 4 [unity_ShadowSplitSpheres3]
Vector 5 [unity_ShadowSplitSqRadii]
Vector 6 [_LightShadowData]
Vector 7 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 37 ALU, 1 TEX
dcl_2d s0
def c8, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
add r0.xyz, t4, -c1
add r2.xyz, t4, -c4
dp3 r0.x, r0, r0
add r1.xyz, t4, -c2
dp3 r0.y, r1, r1
add r1.xyz, t4, -c3
dp3 r0.z, r1, r1
dp3 r0.w, r2, r2
add r0, r0, -c5
cmp r0, r0, c8.x, c8.y
mov r1.x, r0.y
mov r1.z, r0.w
mov r1.y, r0.z
add_sat r1.xyz, r1, -r0
mul r2.xyz, r1.x, t1
mad r0.xyz, r0.x, t0, r2
mad r0.xyz, r1.y, t2, r0
mad r0.xyz, t3, r1.z, r0
add r1.xyz, -t4, c7
dp3 r1.x, r1, r1
rsq r1.x, r1.x
rcp r1.x, r1.x
mad_sat r1.x, r1, c6.z, c6.w
texld r2, r0, s0
mov r0.x, c6
add r0.x, c8.y, -r0
mad r0.x, r2, r0, c6
mul r2.x, -t4.w, c0.w
add r2.x, r2, c8.y
mul r2.xy, r2.x, c8.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c8.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c8
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 0 [unity_ShadowSplitSpheres0] 4
Vector 16 [unity_ShadowSplitSpheres1] 4
Vector 32 [unity_ShadowSplitSpheres2] 4
Vector 48 [unity_ShadowSplitSpheres3] 4
Vector 64 [unity_ShadowSplitSqRadii] 4
Vector 384 [_LightShadowData] 4
Vector 400 [unity_ShadowFadeCenterAndType] 4
BindCB "UnityPerCamera" 0
BindCB "UnityShadows" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 32 instructions, 2 temp regs, 0 temp arrays:
// ALU 26 float, 0 int, 1 uint
// TEX 0 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedehfdffddekigboeafomdgidfgeolncnbabaaaaaaneafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaeaaaa
eaaaaaaacnabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabkaaaaaafkaiaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaacaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaaaafaaaaaaegiccaiaebaaaaaaabaaaaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadbaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaabaaaaaaaeaaaaaadhaaaaaphcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaceaaaaa
aaaaaaiaaaaaaaiaaaaaaaiaaaaaaaaaabaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaadeaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaehaaaaalbcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaaaaaaaaa
aagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaia
ebaaaaaaabaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaaaaaaaaaj
ocaabaaaaaaaaaaaagbjbaaaafaaaaaaagijcaiaebaaaaaaabaaaaaabjaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaabaaaaaabiaaaaaadkiacaaaabaaaaaabiaaaaaaaacaaaah
bccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaa
aaaaaaaadkbabaiaebaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaiadpdiaaaaakdcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaahpedaaaaaaaaaaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
dcaaaaakeccabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadl
akaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaaf
cccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}

SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 0 [unity_ShadowSplitSpheres0] 4
Vector 16 [unity_ShadowSplitSpheres1] 4
Vector 32 [unity_ShadowSplitSpheres2] 4
Vector 48 [unity_ShadowSplitSpheres3] 4
Vector 64 [unity_ShadowSplitSqRadii] 4
Vector 384 [_LightShadowData] 4
Vector 400 [unity_ShadowFadeCenterAndType] 4
BindCB "UnityPerCamera" 0
BindCB "UnityShadows" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 32 instructions, 2 temp regs, 0 temp arrays:
// ALU 26 float, 0 int, 1 uint
// TEX 0 (0 load, 1 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecednjimmkpkglhenecngjmdodgjnmhighkaabaaaaaaoiaiaaaaafaaaaaa
deaaaaaadaadaaaaomahaaaapmahaaaaleaiaaaaebgpgodjpeacaaaapeacaaaa
aaacppppkiacaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaa
aaaaaaaaaaaaafaaabaaaaaaaaaaaaaaabaaaaaaafaaabaaaaaaaaaaabaabiaa
acaaagaaaaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaiadpaaaahpedibiaiadl
aaaaaaaafbaaaaafajaaapkaaaaaaaaaaaaaiadpaaaaaaiaaaaaialpbpaaaaac
aaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaahla
bpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaaja
aaaiapkaacaaaaadaaaaahiaaeaaoelaabaaoekbaiaaaaadaaaaabiaaaaaoeia
aaaaoeiaacaaaaadabaaahiaaeaaoelaacaaoekbaiaaaaadaaaaaciaabaaoeia
abaaoeiaacaaaaadabaaahiaaeaaoelaadaaoekbaiaaaaadaaaaaeiaabaaoeia
abaaoeiaacaaaaadabaaahiaaeaaoelaaeaaoekbaiaaaaadaaaaaiiaabaaoeia
abaaoeiaacaaaaadaaaaapiaaaaaoeiaafaaoekbfiaaaaaeabaaahiaaaaaoeia
ajaakkkaajaappkafiaaaaaeaaaaapiaaaaaoeiaajaaaakaajaaffkaacaaaaad
acaaadiaabaaoeiaaaaamjiaacaaaaadacaaaeiaabaakkiaaaaappiaalaaaaad
aaaaaoiaacaabliaajaaaakaafaaaaadabaaahiaaaaappiaabaaoelaaeaaaaae
abaaahiaaaaaoelaaaaaaaiaabaaoeiaaeaaaaaeabaaahiaacaaoelaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaadaaoelaaaaaffiaabaaoeiaecaaaaadaaaacpia
aaaaoeiaaaaioekaabaaaaacaaaaaciaajaaffkabcaaaaaeabaacbiaaaaaaaia
aaaaffiaagaaaakaacaaaaadacaaahiaaeaaoelaahaaoekbaiaaaaadaaaaabia
acaaoeiaacaaoeiaahaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaabiaaaaaaaia
aeaaaaaeaaaabbiaaaaaaaiaagaakkkaagaappkaacaaaaadabaadbiaaaaaaaia
abaaaaiaaeaaaaaeaaaaabiaaeaapplaaaaappkbaaaaffiaafaaaaadaaaaadia
aaaaaaiaaiaaoekabdaaaaacaaaaadiaaaaaoeiaaeaaaaaeabaaceiaaaaaffia
aiaakkkbaaaaaaiaabaaaaacabaaciiaaaaaffiaabaaaaacabaacciaajaaffka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcleaeaaaaeaaaaaaacnabaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabkaaaaaa
fkaiaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaafaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaa
egiccaiaebaaaaaaabaaaaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaa
egiccaiaebaaaaaaabaaaaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaa
egiccaiaebaaaaaaabaaaaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadbaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaabaaaaaaaeaaaaaadhaaaaaphcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaaceaaaaaaaaaaaiaaaaaaaia
aaaaaaiaaaaaaaaaabaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgaobaaaaaaaaaaadeaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
egbcbaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegbcbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaehaaaaal
bcaabaaaaaaaaaaaegaabaaaaaaaaaaaaghabaaaaaaaaaaaaagabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaaakiacaiaebaaaaaaabaaaaaa
biaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaabiaaaaaaaaaaaaajocaabaaaaaaaaaaa
agbjbaaaafaaaaaaagijcaiaebaaaaaaabaaaaaabjaaaaaabaaaaaahccaabaaa
aaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
abaaaaaabiaaaaaadkiacaaaabaaaaaabiaaaaaaaacaaaahbccabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaadkbabaia
ebaaaaaaafaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdiaaaaak
dcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaahpedaaaaaaaa
aaaaaaaabkaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakeccabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaibiaiadlakaabaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaaiaaaaaaaaaaaaaaaejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" "SHADOWS_SPLIT_SPHERES" }
"!!GLES3"
}

}

#LINE 183


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
    o.lightDir = ObjSpaceLightDir( v.vertex).xyz;
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
    o.lightDir = ObjSpaceLightDir( v.vertex).xyz;
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
    o.lightDir = ObjSpaceLightDir( v.vertex).xyz;
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
    o.lightDir = ObjSpaceLightDir( v.vertex).xyz;
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
    o.lightDir = ObjSpaceLightDir( v.vertex).xyz;
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

#LINE 244

        }
		
	} 

}