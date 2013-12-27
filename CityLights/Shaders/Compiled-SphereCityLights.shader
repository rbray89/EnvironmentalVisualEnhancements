Shader "Sphere/CityLight" {
	Properties {
		_Color ("Color Tint", Color) = (1,1,1,1)
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB) (A)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 100
		_DetailOffset ("Detail Offset", Color) = (0,0,0,0)
	}
	Category {
	   Lighting On
	   ZWrite Off
	   Cull Back
	   Blend SrcAlpha OneMinusSrcAlpha
	   Tags {
	   "Queue"="Transparent"
	   "RenderMode"="Transparent"
	   }
	   SubShader {  	
        
     	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 6
//   d3d9 - ALU: 35 to 40
//   d3d11 - ALU: 28 to 31, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (tmpvar_2 - tmpvar_1);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_3, p_3)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_4, p_4)) - (1.0015 * sqrt(dot (p_5, p_5)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_6 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec4 c_18;
  c_18.w = (min (tmpvar_17.w, xlv_TEXCOORD0) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 16.0)), 0.0, 1.0)));
  c_18.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_18.w;
  c_1.xyz = tmpvar_17.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c10, -5000.00000000, 0.00001000, 250.00000000, 1.00150001
def c11, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
add r2.xyz, r1, -r0
dp3 r0.w, r2, r2
add r2.xyz, -r0, c8
add r1.xyz, -r1, c8
dp3 r1.x, r1, r1
rsq r0.x, r1.x
mul r1.xyz, v1, c9.w
rsq r0.w, r0.w
dp3 r0.y, r2, r2
rcp r0.x, r0.x
rsq r0.y, r0.y
add r0.x, r0, c10
mul r0.x, r0, r0
mad_sat r0.x, -r0, c10.y, c10.z
rcp r0.w, r0.w
rcp r0.y, r0.y
mad_sat r0.y, -r0.w, c10.w, r0
dp3 r0.z, v0, v0
mul o1.x, r0, r0.y
rsq r0.x, r0.z
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c11.x
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmafcnigmpdmkmikmljpjkebeoepkhoaabaaaaaaoeafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceiaeaaaaeaaaabaa
bcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgbfbaaaaaaaaaaaagijcaaaabaaaaaaanaaaaaa
dcaaaaakocaabaaaaaaaaaaaagijcaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
fgaobaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaafgaobaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaafgaobaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaajgahbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaaj
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaeajmmfdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaakmmfchdhabeaaaaaaaaahkedbaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dccaaaakbcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaachdbiadp
akaabaaaaaaaaaaadiaaaaahbccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaa
agaabaaaaaaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
abaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaihccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_38;
  highp float lightIntensity_39;
  mediump float tmpvar_40;
  tmpvar_40 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * 16.0));
  lightIntensity_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_3 * (1.0 - clamp (lightIntensity_39, 0.0, 1.0)));
  c_38.w = tmpvar_41;
  c_38.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_38;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_38;
  highp float lightIntensity_39;
  mediump float tmpvar_40;
  tmpvar_40 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * 16.0));
  lightIntensity_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_3 * (1.0 - clamp (lightIntensity_39, 0.0, 1.0)));
  c_38.w = tmpvar_41;
  c_38.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_38;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 396
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 453
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 402
#line 414
#line 435
#line 462
#line 414
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 418
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 422
    o.localPos = normalize(v.vertex.xyz);
}
#line 462
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 466
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 470
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 474
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 396
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 453
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 402
#line 414
#line 435
#line 462
#line 402
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 406
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 410
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 439
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 443
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 447
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 451
    o.Emission = main.xyz;
}
#line 476
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 478
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 482
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 486
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 490
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 494
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (tmpvar_2 - tmpvar_1);
  vec4 tmpvar_6;
  tmpvar_6 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_3, p_3)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_4, p_4)) - (1.0015 * sqrt(dot (p_5, p_5)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_7 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec4 c_18;
  c_18.w = (min (tmpvar_17.w, xlv_TEXCOORD0) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 16.0)), 0.0, 1.0)));
  c_18.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_18.w;
  c_1.xyz = tmpvar_17.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 11 [unity_Scale]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c12, -5000.00000000, 0.00001000, 250.00000000, 1.00150001
def c13, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r2.xyz, r1, -r0
add r0.xyz, -r0, c8
dp3 r0.y, r0, r0
add r1.xyz, -r1, c8
dp3 r1.x, r1, r1
rsq r0.x, r1.x
dp3 r0.w, r2, r2
rsq r0.w, r0.w
rsq r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, c12
mul r0.z, r0.x, r0.x
dp4 r0.x, v0, c0
rcp r0.w, r0.w
rcp r0.y, r0.y
mad_sat r1.w, -r0, c12, r0.y
mad_sat r0.z, -r0, c12.y, c12
mul o1.x, r0.z, r1.w
dp4 r0.w, v0, c3
dp4 r0.y, v0, c1
dp4 r0.z, v0, c2
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c9.x
mad o5.xy, r1.z, c10.zwzw, r1
mul r1.xyz, v1, c11.w
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mov o5.zw, r0
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c13.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 31 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmmcdlcmdpkipmggheofdcefpojpeebcdabaaaaaajeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiocaabaaa
abaaaaaafgbfbaaaaaaaaaaaagijcaaaabaaaaaaanaaaaaadcaaaaakocaabaaa
abaaaaaaagijcaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaakocaabaaaabaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
fgaobaaaabaaaaaadcaaaaakocaabaaaabaaaaaaagijcaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaafgaobaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajocaabaaaabaaaaaa
fgaobaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahccaabaaa
abaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaa
egaabaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaeajmmfdiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dccaaaakccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaakmmfchdh
abeaaaaaaaaahkedbaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaakbcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaachdbiadpakaabaaaabaaaaaa
diaaaaahbccabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahoccabaaaabaaaaaaagaabaaaabaaaaaa
agbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaabaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaihccabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  mediump vec4 tmpvar_42;
  mediump vec3 lightDir_43;
  lightDir_43 = _WorldSpaceLightPos0.xyz;
  mediump float atten_44;
  atten_44 = tmpvar_36;
  lowp vec4 c_45;
  highp float lightIntensity_46;
  mediump float tmpvar_47;
  tmpvar_47 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_43) - 0.01) / 0.99) * atten_44) * 16.0));
  lightIntensity_46 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_3 * (1.0 - clamp (lightIntensity_46, 0.0, 1.0)));
  c_45.w = tmpvar_48;
  c_45.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42 = c_45;
  c_1 = tmpvar_42;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_9;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  mediump float atten_39;
  atten_39 = tmpvar_36;
  lowp vec4 c_40;
  highp float lightIntensity_41;
  mediump float tmpvar_42;
  tmpvar_42 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * atten_39) * 16.0));
  lightIntensity_41 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_3 * (1.0 - clamp (lightIntensity_41, 0.0, 1.0)));
  c_40.w = tmpvar_43;
  c_40.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_40;
  c_1 = tmpvar_37;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 422
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 426
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 430
    o.localPos = normalize(v.vertex.xyz);
}
#line 471
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 475
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 479
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 484
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 410
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 414
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 418
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 447
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 451
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 455
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 459
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 486
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 488
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 492
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 496
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 500
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 504
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (tmpvar_2 - tmpvar_1);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_3, p_3)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_4, p_4)) - (1.0015 * sqrt(dot (p_5, p_5)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_6 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec4 c_18;
  c_18.w = (min (tmpvar_17.w, xlv_TEXCOORD0) * (1.0 - clamp ((_LightColor0.w * (((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * 16.0)), 0.0, 1.0)));
  c_18.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_18.w;
  c_1.xyz = tmpvar_17.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c10, -5000.00000000, 0.00001000, 250.00000000, 1.00150001
def c11, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
add r2.xyz, r1, -r0
dp3 r0.w, r2, r2
add r2.xyz, -r0, c8
add r1.xyz, -r1, c8
dp3 r1.x, r1, r1
rsq r0.x, r1.x
mul r1.xyz, v1, c9.w
rsq r0.w, r0.w
dp3 r0.y, r2, r2
rcp r0.x, r0.x
rsq r0.y, r0.y
add r0.x, r0, c10
mul r0.x, r0, r0
mad_sat r0.x, -r0, c10.y, c10.z
rcp r0.w, r0.w
rcp r0.y, r0.y
mad_sat r0.y, -r0.w, c10.w, r0
dp3 r0.z, v0, v0
mul o1.x, r0, r0.y
rsq r0.x, r0.z
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c11.x
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 30 instructions, 2 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddmafcnigmpdmkmikmljpjkebeoepkhoaabaaaaaaoeafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceiaeaaaaeaaaabaa
bcabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgbfbaaaaaaaaaaaagijcaaaabaaaaaaanaaaaaa
dcaaaaakocaabaaaaaaaaaaaagijcaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
fgaobaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaafgaobaaaaaaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaafgaobaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaajgahbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaaj
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaiaebaaaaaaaaaaaaaaaeaaaaaa
baaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaelaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaeajmmfdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaakmmfchdhabeaaaaaaaaahkedbaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
dccaaaakbcaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaachdbiadp
akaabaaaaaaaaaaadiaaaaahbccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahoccabaaaabaaaaaa
agaabaaaaaaaaaaaagbjbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
abaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaihccabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_38;
  highp float lightIntensity_39;
  mediump float tmpvar_40;
  tmpvar_40 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * 16.0));
  lightIntensity_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_3 * (1.0 - clamp (lightIntensity_39, 0.0, 1.0)));
  c_38.w = tmpvar_41;
  c_38.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_38;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  mediump vec4 tmpvar_36;
  mediump vec3 lightDir_37;
  lightDir_37 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_38;
  highp float lightIntensity_39;
  mediump float tmpvar_40;
  tmpvar_40 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_37) - 0.01) / 0.99) * 16.0));
  lightIntensity_39 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_3 * (1.0 - clamp (lightIntensity_39, 0.0, 1.0)));
  c_38.w = tmpvar_41;
  c_38.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_36 = c_38;
  c_1 = tmpvar_36;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 396
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 453
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 402
#line 414
#line 435
#line 462
#line 414
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 418
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 422
    o.localPos = normalize(v.vertex.xyz);
}
#line 462
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 466
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 470
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 474
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 396
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 453
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
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
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 402
#line 414
#line 435
#line 462
#line 402
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 406
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 410
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 439
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 443
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 447
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 451
    o.Emission = main.xyz;
}
#line 476
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 478
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 482
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 486
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 490
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 494
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 unity_Scale;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  vec3 p_3;
  p_3 = (tmpvar_1 - _WorldSpaceCameraPos);
  vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 p_5;
  p_5 = (tmpvar_2 - tmpvar_1);
  vec4 tmpvar_6;
  tmpvar_6 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec4 o_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_3, p_3)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_4, p_4)) - (1.0015 * sqrt(dot (p_5, p_5)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(gl_Vertex.xyz);
  xlv_TEXCOORD2 = (tmpvar_7 * (gl_Normal * unity_Scale.w));
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_8;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD0;
uniform vec4 _DetailOffset;
uniform vec4 _Color;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec2 uv_2;
  float r_3;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    float y_over_x_4;
    y_over_x_4 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_5;
    float x_6;
    x_6 = (y_over_x_4 * inversesqrt(((y_over_x_4 * y_over_x_4) + 1.0)));
    s_5 = (sign(x_6) * (1.5708 - (sqrt((1.0 - abs(x_6))) * (1.5708 + (abs(x_6) * (-0.214602 + (abs(x_6) * (0.0865667 + (abs(x_6) * -0.0310296)))))))));
    r_3 = s_5;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_3 = (s_5 + 3.14159);
      } else {
        r_3 = (r_3 - 3.14159);
      };
    };
  } else {
    r_3 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_2.x = (0.5 + (0.159155 * r_3));
  float x_7;
  x_7 = -(xlv_TEXCOORD1.y);
  uv_2.y = (0.31831 * (1.5708 - (sign(x_7) * (1.5708 - (sqrt((1.0 - abs(x_7))) * (1.5708 + (abs(x_7) * (-0.214602 + (abs(x_7) * (0.0865667 + (abs(x_7) * -0.0310296)))))))))));
  float r_8;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    float y_over_x_9;
    y_over_x_9 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    float s_10;
    float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  float tmpvar_12;
  tmpvar_12 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  vec2 tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD1.xy);
  vec2 tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD1.xy);
  vec4 tmpvar_15;
  tmpvar_15.x = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_15.y = dFdx(tmpvar_12);
  tmpvar_15.z = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_15.w = dFdy(tmpvar_12);
  vec3 tmpvar_16;
  tmpvar_16 = abs(xlv_TEXCOORD1);
  vec4 tmpvar_17;
  tmpvar_17 = ((texture2DGradARB (_MainTex, uv_2, tmpvar_15.xy, tmpvar_15.zw) * _Color) * mix (mix (texture2D (_DetailTex, ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy)), texture2D (_DetailTex, ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy)), tmpvar_16.xxxx), texture2D (_DetailTex, ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy)), tmpvar_16.yyyy));
  vec4 c_18;
  c_18.w = (min (tmpvar_17.w, xlv_TEXCOORD0) * (1.0 - clamp ((_LightColor0.w * ((((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) - 0.01) / 0.99) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 16.0)), 0.0, 1.0)));
  c_18.xyz = vec3(0.0, 0.0, 0.0);
  c_1.w = c_18.w;
  c_1.xyz = tmpvar_17.xyz;
  gl_FragData[0] = c_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_Object2World]
Vector 11 [unity_Scale]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c12, -5000.00000000, 0.00001000, 250.00000000, 1.00150001
def c13, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dp4 r1.z, v0, c6
dp4 r1.y, v0, c5
dp4 r1.x, v0, c4
mov r0.z, c6.w
mov r0.x, c4.w
mov r0.y, c5.w
add r2.xyz, r1, -r0
add r0.xyz, -r0, c8
dp3 r0.y, r0, r0
add r1.xyz, -r1, c8
dp3 r1.x, r1, r1
rsq r0.x, r1.x
dp3 r0.w, r2, r2
rsq r0.w, r0.w
rsq r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, c12
mul r0.z, r0.x, r0.x
dp4 r0.x, v0, c0
rcp r0.w, r0.w
rcp r0.y, r0.y
mad_sat r1.w, -r0, c12, r0.y
mad_sat r0.z, -r0, c12.y, c12
mul o1.x, r0.z, r1.w
dp4 r0.w, v0, c3
dp4 r0.y, v0, c1
dp4 r0.z, v0, c2
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c9.x
mad o5.xy, r1.z, c10.zwzw, r1
mul r1.xyz, v1, c11.w
mov o0, r0
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mov o5.zw, r0
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c13.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 35 instructions, 3 temp regs, 0 temp arrays:
// ALU 31 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmmcdlcmdpkipmggheofdcefpojpeebcdabaaaaaajeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaabaoaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaoabaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaaeaaaaeaaaabaadiabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadbccabaaaabaaaaaagfaaaaadoccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaaegiccaaaabaaaaaaapaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadiaaaaaiocaabaaa
abaaaaaafgbfbaaaaaaaaaaaagijcaaaabaaaaaaanaaaaaadcaaaaakocaabaaa
abaaaaaaagijcaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaakocaabaaaabaaaaaaagijcaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
fgaobaaaabaaaaaadcaaaaakocaabaaaabaaaaaaagijcaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaafgaobaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaaegiccaaaabaaaaaaapaaaaaaaaaaaaajocaabaaaabaaaaaa
fgaobaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaaeaaaaaabaaaaaahccaabaaa
abaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafdcaabaaaabaaaaaa
egaabaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaeajmmfdiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dccaaaakccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaakmmfchdh
abeaaaaaaaaahkedbaaaaaahecaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadccaaaakbcaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaachdbiadpakaabaaaabaaaaaa
diaaaaahbccabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahoccabaaaabaaaaaaagaabaaaabaaaaaa
agbjbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaabaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaihccabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float tmpvar_36;
  mediump float lightShadowDataX_37;
  highp float dist_38;
  lowp float tmpvar_39;
  tmpvar_39 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = _LightShadowData.x;
  lightShadowDataX_37 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = max (float((dist_38 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_37);
  tmpvar_36 = tmpvar_41;
  mediump vec4 tmpvar_42;
  mediump vec3 lightDir_43;
  lightDir_43 = _WorldSpaceLightPos0.xyz;
  mediump float atten_44;
  atten_44 = tmpvar_36;
  lowp vec4 c_45;
  highp float lightIntensity_46;
  mediump float tmpvar_47;
  tmpvar_47 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_43) - 0.01) / 0.99) * atten_44) * 16.0));
  lightIntensity_46 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = (tmpvar_3 * (1.0 - clamp (lightIntensity_46, 0.0, 1.0)));
  c_45.w = tmpvar_48;
  c_45.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42 = c_45;
  c_1 = tmpvar_42;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_9;
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = o_10;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float tmpvar_36;
  tmpvar_36 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_37;
  mediump vec3 lightDir_38;
  lightDir_38 = _WorldSpaceLightPos0.xyz;
  mediump float atten_39;
  atten_39 = tmpvar_36;
  lowp vec4 c_40;
  highp float lightIntensity_41;
  mediump float tmpvar_42;
  tmpvar_42 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_38) - 0.01) / 0.99) * atten_39) * 16.0));
  lightIntensity_41 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_3 * (1.0 - clamp (lightIntensity_41, 0.0, 1.0)));
  c_40.w = tmpvar_43;
  c_40.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_37 = c_40;
  c_1 = tmpvar_37;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 422
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 426
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 430
    o.localPos = normalize(v.vertex.xyz);
}
#line 471
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 475
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 479
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 484
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 410
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 414
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 418
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 447
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 451
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 455
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 459
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 486
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 488
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 492
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 496
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 500
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 504
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  mediump vec4 tmpvar_39;
  mediump vec3 lightDir_40;
  lightDir_40 = _WorldSpaceLightPos0.xyz;
  mediump float atten_41;
  atten_41 = shadow_36;
  lowp vec4 c_42;
  highp float lightIntensity_43;
  mediump float tmpvar_44;
  tmpvar_44 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_40) - 0.01) / 0.99) * atten_41) * 16.0));
  lightIntensity_43 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (tmpvar_3 * (1.0 - clamp (lightIntensity_43, 0.0, 1.0)));
  c_42.w = tmpvar_45;
  c_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_39 = c_42;
  c_1 = tmpvar_39;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 422
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 426
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 430
    o.localPos = normalize(v.vertex.xyz);
}
#line 471
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 475
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 479
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 484
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 410
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 414
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 418
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 447
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 451
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 455
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 459
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 486
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 488
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 492
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 496
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 500
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 504
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex).xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec3 p_4;
  p_4 = (tmpvar_2 - _WorldSpaceCameraPos);
  highp vec3 p_5;
  p_5 = (tmpvar_3 - _WorldSpaceCameraPos);
  highp vec3 p_6;
  p_6 = (tmpvar_3 - tmpvar_2);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (clamp ((250.0 - (1e-05 * pow ((sqrt(dot (p_4, p_4)) - 5000.0), 2.0))), 0.0, 1.0) * clamp ((sqrt(dot (p_5, p_5)) - (1.0015 * sqrt(dot (p_6, p_6)))), 0.0, 1.0));
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD0;
uniform lowp vec4 _DetailOffset;
uniform lowp vec4 _Color;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  mediump vec4 detail_4;
  mediump vec4 detailZ_5;
  mediump vec4 detailY_6;
  mediump vec4 detailX_7;
  mediump vec4 main_8;
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.z)))) {
    highp float y_over_x_11;
    y_over_x_11 = (xlv_TEXCOORD1.z / xlv_TEXCOORD1.x);
    float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.z >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(xlv_TEXCOORD1.z) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  highp float x_14;
  x_14 = -(xlv_TEXCOORD1.y);
  uv_9.y = (0.31831 * (1.5708 - (sign(x_14) * (1.5708 - (sqrt((1.0 - abs(x_14))) * (1.5708 + (abs(x_14) * (-0.214602 + (abs(x_14) * (0.0865667 + (abs(x_14) * -0.0310296)))))))))));
  highp float r_15;
  if ((abs(xlv_TEXCOORD1.x) > (1e-08 * abs(xlv_TEXCOORD1.y)))) {
    highp float y_over_x_16;
    y_over_x_16 = (xlv_TEXCOORD1.y / xlv_TEXCOORD1.x);
    highp float s_17;
    highp float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((xlv_TEXCOORD1.x < 0.0)) {
      if ((xlv_TEXCOORD1.y >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(xlv_TEXCOORD1.y) * 1.5708);
  };
  highp float tmpvar_19;
  tmpvar_19 = (0.31831 * (1.5708 - (sign(xlv_TEXCOORD1.z) * (1.5708 - (sqrt((1.0 - abs(xlv_TEXCOORD1.z))) * (1.5708 + (abs(xlv_TEXCOORD1.z) * (-0.214602 + (abs(xlv_TEXCOORD1.z) * (0.0865667 + (abs(xlv_TEXCOORD1.z) * -0.0310296)))))))))));
  highp vec2 tmpvar_20;
  tmpvar_20 = dFdx(xlv_TEXCOORD1.xy);
  highp vec2 tmpvar_21;
  tmpvar_21 = dFdy(xlv_TEXCOORD1.xy);
  highp vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19);
  lowp vec4 tmpvar_23;
  tmpvar_23 = (texture2DGradEXT (_MainTex, uv_9, tmpvar_22.xy, tmpvar_22.zw) * _Color);
  main_8 = tmpvar_23;
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_24 = texture2D (_DetailTex, P_25);
  detailX_7 = tmpvar_24;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_26 = texture2D (_DetailTex, P_27);
  detailY_6 = tmpvar_26;
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_28 = texture2D (_DetailTex, P_29);
  detailZ_5 = tmpvar_28;
  highp vec3 tmpvar_30;
  tmpvar_30 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_31;
  tmpvar_31 = mix (detailZ_5, detailX_7, tmpvar_30.xxxx);
  detail_4 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32 = mix (detail_4, detailY_6, tmpvar_30.yyyy);
  detail_4 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33 = (main_8 * detail_4);
  main_8 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = min (tmpvar_33.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_34;
  mediump vec3 tmpvar_35;
  tmpvar_35 = tmpvar_33.xyz;
  tmpvar_2 = tmpvar_35;
  lowp float shadow_36;
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_38;
  tmpvar_38 = (_LightShadowData.x + (tmpvar_37 * (1.0 - _LightShadowData.x)));
  shadow_36 = tmpvar_38;
  mediump vec4 tmpvar_39;
  mediump vec3 lightDir_40;
  lightDir_40 = _WorldSpaceLightPos0.xyz;
  mediump float atten_41;
  atten_41 = shadow_36;
  lowp vec4 c_42;
  highp float lightIntensity_43;
  mediump float tmpvar_44;
  tmpvar_44 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_40) - 0.01) / 0.99) * atten_41) * 16.0));
  lightIntensity_43 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (tmpvar_3 * (1.0 - clamp (lightIntensity_43, 0.0, 1.0)));
  c_42.w = tmpvar_45;
  c_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_39 = c_42;
  c_1 = tmpvar_39;
  c_1.xyz = c_1.xyz;
  c_1.xyz = (c_1.xyz + tmpvar_2);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 422
void vert( inout appdata_full v, out Input o ) {
    highp vec3 vertexPos = (_Object2World * v.vertex).xyz;
    #line 426
    highp vec3 origin = (_Object2World * vec4( 0.0, 0.0, 0.0, 1.0)).xyz;
    highp float dist = distance( vertexPos, _WorldSpaceCameraPos.xyz);
    highp float alpha = xll_saturate_f((250.0 - (1e-05 * pow( (dist - 5000.0), 2.0))));
    o.distAlpha = (alpha * xll_saturate_f((distance( origin, _WorldSpaceCameraPos) - (1.0015 * distance( origin, vertexPos)))));
    #line 430
    o.localPos = normalize(v.vertex.xyz);
}
#line 471
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 475
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 479
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 484
    return o;
}

out highp float xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = float(xl_retval.cust_distAlpha);
    xlv_TEXCOORD1 = vec3(xl_retval.cust_localPos);
    xlv_TEXCOORD2 = vec3(xl_retval.normal);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 404
struct Input {
    highp float distAlpha;
    highp vec3 localPos;
};
#line 461
struct v2f_surf {
    highp vec4 pos;
    highp float cust_distAlpha;
    highp vec3 cust_localPos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
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
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
#line 401
uniform highp float _DetailScale;
uniform lowp vec4 _Color;
uniform lowp vec4 _DetailOffset;
#line 410
#line 422
#line 443
#line 471
#line 410
mediump vec4 LightingNone( in SurfaceOutput s, in mediump vec3 lightDir, in mediump float atten ) {
    mediump float NdotL = dot( s.Normal, lightDir);
    mediump float diff = ((NdotL - 0.01) / 0.99);
    #line 414
    highp float lightIntensity = (_LightColor0.w * ((diff * atten) * 16.0));
    highp float satLight = xll_saturate_f(lightIntensity);
    highp float invlight = (1.0 - satLight);
    lowp vec4 c;
    #line 418
    c.w = (s.Alpha * invlight);
    c.xyz = vec3( 0.0);
    return c;
}
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
#line 443
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    #line 447
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    highp vec4 uvdd = Derivatives( pos);
    mediump vec4 main = (xll_tex2Dgrad( _MainTex, uv, uvdd.xy, uvdd.zw) * _Color);
    #line 451
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    pos = abs(pos);
    #line 455
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    o.Alpha = min( main.w, IN.distAlpha);
    #line 459
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 486
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 488
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 492
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 496
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 500
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 504
    return c;
}
in highp float xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.cust_distAlpha = float(xlv_TEXCOORD0);
    xlt_IN.cust_localPos = vec3(xlv_TEXCOORD1);
    xlt_IN.normal = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 2
//   d3d9 - ALU: 83 to 84, TEX: 6 to 7
//   d3d11 - ALU: 60 to 63, TEX: 3 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_Color]
Vector 4 [_DetailOffset]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 83 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c6, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c7, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c8, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c9, 0.15915494, 0.50000000, -0.01000214, 16.15779114
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mul r0.zw, v1.xyxy, c2.x
add r1.xy, r0.zwzw, c4
abs r2.z, v1
abs r2.xy, v1
max r0.x, r2.z, r2
rcp r0.y, r0.x
min r0.x, r2.z, r2
mul r2.w, r0.x, r0.y
mul r0.x, r2.w, r2.w
mad r0.y, r0.x, c7, c7.z
mad r0.y, r0, r0.x, c7.w
mad r0.y, r0, r0.x, c8.x
mad r0.y, r0, r0.x, c8
mad r3.x, r0.y, r0, c8.z
mul r2.w, r3.x, r2
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c4
dsy r3.xy, v1
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
add r0.x, r2.z, -r2
add r0.y, -r2.w, c8.w
cmp r0.z, -r0.x, r2.w, r0.y
add r0.w, -r0.z, c6
cmp r2.x, v1, r0.z, r0.w
mul r0.xy, v1.zxzw, c2.x
add r0.xy, r0, c4
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
cmp r2.x, v1.z, r2, -r2
mad r1.z, r2.x, c9.x, c9.y
abs r2.x, -v1.y
add r1.y, -r2.z, c5
mad r1.x, r2.z, c5.z, c5.w
mad r1.x, r2.z, r1, c6
mad r1.x, r2.z, r1, c6.y
add r2.z, -r2.x, c5.y
mad r2.y, r2.x, c5.z, c5.w
mad r2.y, r2, r2.x, c6.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.y, r1.x, r1
cmp r1.x, v1.z, c5, c5.y
mul r1.w, r1.x, r1.y
mad r1.w, -r1, c6.z, r1.y
rsq r2.z, r2.z
mad r2.x, r2.y, r2, c6.y
rcp r2.z, r2.z
mul r2.y, r2.x, r2.z
cmp r2.x, -v1.y, c5, c5.y
mul r2.z, r2.x, r2.y
mad r1.y, -r2.z, c6.z, r2
mad r1.w, r1.x, c6, r1
mad r1.x, r2, c6.w, r1.y
mul r1.y, r1.w, c7.x
dsx r2.y, r1
dsx r2.zw, v1.xyxy
mul r3.xy, r3, r3
add r2.x, r3, r3.y
mul r1.w, r1.x, c7.x
mul r2.zw, r2, r2
add r1.x, r2.z, r2.w
rsq r2.x, r2.x
rsq r1.x, r1.x
rcp r2.z, r2.x
rcp r1.x, r1.x
mul r2.x, r1, c9
mul r1.x, r2.z, c9
dsy r1.y, r1
texldd r1, r1.zwzw, s0, r2, r1
mul r1, r1, c3
mul_pp r0, r1, r0
mov_pp oC0.xyz, r0
dp3_pp r2.z, v2, c0
add_pp r2.x, r2.z, c9.z
mul_pp r2.x, r2, c1.w
mul_pp_sat r1.x, r2, c9.w
add r0.y, -r1.x, c5
min_pp r0.x, r0.w, v0
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 96 // 96 used size, 6 vars
Vector 16 [_LightColor0] 4
Float 48 [_DetailScale]
Vector 64 [_Color] 4
Vector 80 [_DetailOffset] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 67 instructions, 4 temp regs, 0 temp arrays:
// ALU 56 float, 0 int, 4 uint
// TEX 3 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjanamcemmpiedaihihlpijdkgfbklanmabaaaaaadeakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefccmajaaaaeaaaaaaaelacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadbcbabaaaabaaaaaagcbaaaadocbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
deaaaaajbcaabaaaaaaaaaaabkbabaiaibaaaaaaabaaaaaadkbabaiaibaaaaaa
abaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaabkbabaiaibaaaaaa
abaaaaaadkbabaiaibaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
aaaaaaaabkbabaiaibaaaaaaabaaaaaadkbabaiaibaaaaaaabaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaai
gcaabaaaaaaaaaaafgbhbaaaabaaaaaafgbhbaiaebaaaaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaa
bkbabaaaabaaaaaadkbabaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaabkbabaaa
abaaaaaadkbabaaaabaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaa
jgbfbaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaa
fgbjbaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaa
ckbabaiaebaaaaaaabaaaaaackbabaaaabaaaaaadcaaaabamcaabaaaabaaaaaa
kgbobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlm
aceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaakgbobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
iedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaakgbobaia
ibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaal
mcaabaaaacaaaaaakgbobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaah
dcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaa
aceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaa
kgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
ckaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaa
aaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaa
alaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
ckaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaal
pcaabaaaabaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaaegiecaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaajgbfbaaa
abaaaaaaagiacaaaaaaaaaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaa
dcaaaaakpcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaai
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibebdicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_Color]
Vector 4 [_DetailOffset]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 84 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c6, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c7, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c8, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c9, 0.15915494, 0.50000000, -0.01000214, 16.15779114
dcl_texcoord0 v0.x
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v4
mul r0.zw, v1.xyxy, c2.x
add r1.xy, r0.zwzw, c4
abs r2.z, v1
abs r2.xy, v1
max r0.x, r2.z, r2
rcp r0.y, r0.x
min r0.x, r2.z, r2
mul r2.w, r0.x, r0.y
mul r0.x, r2.w, r2.w
mad r0.y, r0.x, c7, c7.z
mad r0.y, r0, r0.x, c7.w
mad r0.y, r0, r0.x, c8.x
mad r0.y, r0, r0.x, c8
mad r3.x, r0.y, r0, c8.z
mul r2.w, r3.x, r2
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c4
dsy r3.xy, v1
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
add r0.x, r2.z, -r2
add r0.y, -r2.w, c8.w
cmp r0.z, -r0.x, r2.w, r0.y
add r0.w, -r0.z, c6
cmp r2.x, v1, r0.z, r0.w
mul r0.xy, v1.zxzw, c2.x
add r0.xy, r0, c4
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
cmp r2.x, v1.z, r2, -r2
mad r1.z, r2.x, c9.x, c9.y
abs r2.x, -v1.y
add r1.y, -r2.z, c5
mad r1.x, r2.z, c5.z, c5.w
mad r1.x, r2.z, r1, c6
mad r1.x, r2.z, r1, c6.y
add r2.z, -r2.x, c5.y
mad r2.y, r2.x, c5.z, c5.w
mad r2.y, r2, r2.x, c6.x
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.y, r1.x, r1
cmp r1.x, v1.z, c5, c5.y
mul r1.w, r1.x, r1.y
mad r1.w, -r1, c6.z, r1.y
rsq r2.z, r2.z
mad r2.x, r2.y, r2, c6.y
rcp r2.z, r2.z
mul r2.y, r2.x, r2.z
cmp r2.x, -v1.y, c5, c5.y
mul r2.z, r2.x, r2.y
mad r1.y, -r2.z, c6.z, r2
mad r1.w, r1.x, c6, r1
mad r1.x, r2, c6.w, r1.y
mul r1.y, r1.w, c7.x
dsx r2.y, r1
dsx r2.zw, v1.xyxy
mul r3.xy, r3, r3
add r2.x, r3, r3.y
mul r1.w, r1.x, c7.x
mul r2.zw, r2, r2
add r1.x, r2.z, r2.w
rsq r2.x, r2.x
rsq r1.x, r1.x
rcp r1.x, r1.x
rcp r2.z, r2.x
mul r2.x, r1, c9
dsy r1.y, r1
mul r1.x, r2.z, c9
texldd r1, r1.zwzw, s0, r2, r1
mul r1, r1, c3
mul_pp r0, r1, r0
mov_pp oC0.xyz, r0
dp3_pp r2.y, v2, c0
texldp r2.x, v4, s2
add_pp r2.y, r2, c9.z
mul_pp r2.x, r2.y, r2
mul_pp r2.x, r2, c1.w
mul_pp_sat r1.x, r2, c9.w
add r0.y, -r1.x, c5
min_pp r0.x, r0.w, v0
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 160 // 160 used size, 7 vars
Vector 16 [_LightColor0] 4
Float 112 [_DetailScale]
Vector 128 [_Color] 4
Vector 144 [_DetailOffset] 4
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_DetailTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
// 71 instructions, 4 temp regs, 0 temp arrays:
// ALU 59 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbmliafhencmegecmkimaodnbgpdmfglhabaaaaaaomakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmajaaaa
eaaaaaaahdacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
bcbabaaaabaaaaaagcbaaaadocbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
deaaaaajbcaabaaaaaaaaaaabkbabaiaibaaaaaaabaaaaaadkbabaiaibaaaaaa
abaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaddaaaaajccaabaaaaaaaaaaabkbabaiaibaaaaaa
abaaaaaadkbabaiaibaaaaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajicaabaaa
aaaaaaaabkbabaiaibaaaaaaabaaaaaadkbabaiaibaaaaaaabaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaai
gcaabaaaaaaaaaaafgbhbaaaabaaaaaafgbhbaiaebaaaaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaa
bkbabaaaabaaaaaadkbabaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaabkbabaaa
abaaaaaadkbabaaaabaaaaaabnaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpalaaaaafdcaabaaaabaaaaaa
jgbfbaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdoamaaaaafmcaabaaaabaaaaaa
fgbjbaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdodbaaaaaiicaabaaaaaaaaaaa
ckbabaiaebaaaaaaabaaaaaackbabaaaabaaaaaadcaaaabamcaabaaaabaaaaaa
kgbobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaadagojjlmdagojjlm
aceaaaaaaaaaaaaaaaaaaaaachbgjidnchbgjidndcaaaaanmcaabaaaabaaaaaa
kgaobaaaabaaaaaakgbobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
iedefjloiedefjlodcaaaaanmcaabaaaabaaaaaakgaobaaaabaaaaaakgbobaia
ibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaakeanmjdpkeanmjdpaaaaaaal
mcaabaaaacaaaaaakgbobaiambaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaiadpelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaah
dcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaa
aceaaaaanlapejeanlapejeaaaaaaaaaaaaaaaaaabaaaaahmcaabaaaaaaaaaaa
kgaobaaaaaaaaaaafgabbaaaadaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
ckaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaakgcaabaaa
aaaaaaaapgaobaaaaaaaaaaaaceaaaaaaaaaaaaaidpjkcdoidpjkcdoaaaaaaaa
alaaaaafccaabaaaabaaaaaackaabaaaaaaaaaaaamaaaaafccaabaaaacaaaaaa
ckaabaaaaaaaaaaaejaaaaanpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaal
pcaabaaaabaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegiecaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaldcaabaaaadaaaaaajgbfbaaa
abaaaaaaagiacaaaaaaaaaaaahaaaaaaegiacaaaaaaaaaaaajaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaadaaaaaa
dcaaaaakpcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaia
ebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akbabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaai
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiaebaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}

#LINE 97

	 	 
	 } 
    }
}