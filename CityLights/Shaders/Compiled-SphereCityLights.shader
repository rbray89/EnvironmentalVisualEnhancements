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
//   opengl - ALU: 39 to 44
//   d3d9 - ALU: 35 to 40
//   d3d11 - ALU: 28 to 31, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Vector 10 [unity_Scale]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[12] = { { 250, 9.9999997e-006, 5000, 0 },
		state.matrix.mvp,
		program.local[5..10],
		{ 1, 1.0015 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.z, c[7].w;
MOV R0.x, c[5].w;
MOV R0.y, c[6].w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.y, vertex.position, c[6];
DP4 R1.x, vertex.position, c[5];
ADD R2.xyz, R1, -R0;
DP3 R0.w, R2, R2;
ADD R2.xyz, -R0, c[9];
ADD R1.xyz, -R1, c[9];
DP3 R1.x, R1, R1;
RSQ R0.x, R1.x;
MUL R1.xyz, vertex.normal, c[10].w;
RSQ R0.w, R0.w;
DP3 R0.y, R2, R2;
RCP R0.x, R0.x;
RSQ R0.y, R0.y;
ADD R0.x, R0, -c[0].z;
MUL R0.x, R0, R0;
MAD R0.x, -R0, c[0].y, c[0];
MIN R0.x, R0, c[11];
MAX R0.x, R0, c[0].w;
RCP R0.w, R0.w;
RCP R0.y, R0.y;
MAD R0.y, -R0.w, c[11], R0;
MIN R0.y, R0, c[11].x;
MAX R0.y, R0, c[0].w;
DP3 R0.z, vertex.position, vertex.position;
MUL result.texcoord[0].x, R0, R0.y;
RSQ R0.x, R0.z;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[0].w;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 3 R-regs
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_30;
  highp float lightIntensity_31;
  mediump float tmpvar_32;
  tmpvar_32 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_29) - 0.01) / 0.99) * 16.0));
  lightIntensity_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_3 * (1.0 - clamp (lightIntensity_31, 0.0, 1.0)));
  c_30.w = tmpvar_33;
  c_30.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28 = c_30;
  c_1 = tmpvar_28;
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_30;
  highp float lightIntensity_31;
  mediump float tmpvar_32;
  tmpvar_32 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_29) - 0.01) / 0.99) * 16.0));
  lightIntensity_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_3 * (1.0 - clamp (lightIntensity_31, 0.0, 1.0)));
  c_30.w = tmpvar_33;
  c_30.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28 = c_30;
  c_1 = tmpvar_28;
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
#line 441
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
#line 450
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
#line 450
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 454
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 458
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 462
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
#line 441
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
#line 450
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 426
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 430
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 434
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 438
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 464
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 466
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 470
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 474
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 478
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 482
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
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_Object2World]
Vector 11 [unity_Scale]
"3.0-!!ARBvp1.0
# 44 ALU
PARAM c[13] = { { 250, 9.9999997e-006, 5000, 0 },
		state.matrix.mvp,
		program.local[5..11],
		{ 1, 1.0015, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP4 R1.z, vertex.position, c[7];
DP4 R1.y, vertex.position, c[6];
DP4 R1.x, vertex.position, c[5];
MOV R0.z, c[7].w;
MOV R0.x, c[5].w;
MOV R0.y, c[6].w;
ADD R2.xyz, R1, -R0;
ADD R0.xyz, -R0, c[9];
DP3 R0.y, R0, R0;
ADD R1.xyz, -R1, c[9];
DP3 R1.x, R1, R1;
RSQ R0.x, R1.x;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
RSQ R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -c[0].z;
MUL R0.x, R0, R0;
MAD R0.x, -R0, c[0].y, c[0];
MIN R0.z, R0.x, c[12].x;
DP4 R0.x, vertex.position, c[1];
RCP R0.w, R0.w;
RCP R0.y, R0.y;
MAD R0.y, -R0.w, c[12], R0;
MIN R0.y, R0, c[12].x;
MAX R1.w, R0.y, c[0];
MAX R0.z, R0, c[0].w;
MUL result.texcoord[0].x, R0.z, R1.w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.y, vertex.position, c[2];
DP4 R0.z, vertex.position, c[3];
MUL R1.xyz, R0.xyww, c[12].z;
MUL R1.y, R1, c[10].x;
ADD result.texcoord[4].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[11].w;
MOV result.position, R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[0].w;
END
# 44 instructions, 3 R-regs
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump vec4 tmpvar_34;
  mediump vec3 lightDir_35;
  lightDir_35 = _WorldSpaceLightPos0.xyz;
  mediump float atten_36;
  atten_36 = tmpvar_28;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_35) - 0.01) / 0.99) * atten_36) * 16.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_34 = c_37;
  c_1 = tmpvar_34;
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_29;
  mediump vec3 lightDir_30;
  lightDir_30 = _WorldSpaceLightPos0.xyz;
  mediump float atten_31;
  atten_31 = tmpvar_28;
  lowp vec4 c_32;
  highp float lightIntensity_33;
  mediump float tmpvar_34;
  tmpvar_34 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_30) - 0.01) / 0.99) * atten_31) * 16.0));
  lightIntensity_33 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_3 * (1.0 - clamp (lightIntensity_33, 0.0, 1.0)));
  c_32.w = tmpvar_35;
  c_32.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_29 = c_32;
  c_1 = tmpvar_29;
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
#line 449
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
#line 459
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
#line 459
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 463
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 467
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 472
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
#line 449
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
#line 459
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 434
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 438
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 442
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 446
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 474
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 476
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 480
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 484
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 488
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 492
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
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Vector 10 [unity_Scale]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[12] = { { 250, 9.9999997e-006, 5000, 0 },
		state.matrix.mvp,
		program.local[5..10],
		{ 1, 1.0015 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.z, c[7].w;
MOV R0.x, c[5].w;
MOV R0.y, c[6].w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.y, vertex.position, c[6];
DP4 R1.x, vertex.position, c[5];
ADD R2.xyz, R1, -R0;
DP3 R0.w, R2, R2;
ADD R2.xyz, -R0, c[9];
ADD R1.xyz, -R1, c[9];
DP3 R1.x, R1, R1;
RSQ R0.x, R1.x;
MUL R1.xyz, vertex.normal, c[10].w;
RSQ R0.w, R0.w;
DP3 R0.y, R2, R2;
RCP R0.x, R0.x;
RSQ R0.y, R0.y;
ADD R0.x, R0, -c[0].z;
MUL R0.x, R0, R0;
MAD R0.x, -R0, c[0].y, c[0];
MIN R0.x, R0, c[11];
MAX R0.x, R0, c[0].w;
RCP R0.w, R0.w;
RCP R0.y, R0.y;
MAD R0.y, -R0.w, c[11], R0;
MIN R0.y, R0, c[11].x;
MAX R0.y, R0, c[0].w;
DP3 R0.z, vertex.position, vertex.position;
MUL result.texcoord[0].x, R0, R0.y;
RSQ R0.x, R0.z;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[0].w;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 3 R-regs
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_30;
  highp float lightIntensity_31;
  mediump float tmpvar_32;
  tmpvar_32 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_29) - 0.01) / 0.99) * 16.0));
  lightIntensity_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_3 * (1.0 - clamp (lightIntensity_31, 0.0, 1.0)));
  c_30.w = tmpvar_33;
  c_30.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28 = c_30;
  c_1 = tmpvar_28;
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  mediump vec3 lightDir_29;
  lightDir_29 = _WorldSpaceLightPos0.xyz;
  lowp vec4 c_30;
  highp float lightIntensity_31;
  mediump float tmpvar_32;
  tmpvar_32 = (_LightColor0.w * (((dot (xlv_TEXCOORD2, lightDir_29) - 0.01) / 0.99) * 16.0));
  lightIntensity_31 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_3 * (1.0 - clamp (lightIntensity_31, 0.0, 1.0)));
  c_30.w = tmpvar_33;
  c_30.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_28 = c_30;
  c_1 = tmpvar_28;
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
#line 441
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
#line 450
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
#line 450
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 454
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 458
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    #line 462
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
#line 441
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
#line 450
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 426
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 430
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 434
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 438
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 464
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 466
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 470
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 474
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 478
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 482
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
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_Object2World]
Vector 11 [unity_Scale]
"3.0-!!ARBvp1.0
# 44 ALU
PARAM c[13] = { { 250, 9.9999997e-006, 5000, 0 },
		state.matrix.mvp,
		program.local[5..11],
		{ 1, 1.0015, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP4 R1.z, vertex.position, c[7];
DP4 R1.y, vertex.position, c[6];
DP4 R1.x, vertex.position, c[5];
MOV R0.z, c[7].w;
MOV R0.x, c[5].w;
MOV R0.y, c[6].w;
ADD R2.xyz, R1, -R0;
ADD R0.xyz, -R0, c[9];
DP3 R0.y, R0, R0;
ADD R1.xyz, -R1, c[9];
DP3 R1.x, R1, R1;
RSQ R0.x, R1.x;
DP3 R0.w, R2, R2;
RSQ R0.w, R0.w;
RSQ R0.y, R0.y;
RCP R0.x, R0.x;
ADD R0.x, R0, -c[0].z;
MUL R0.x, R0, R0;
MAD R0.x, -R0, c[0].y, c[0];
MIN R0.z, R0.x, c[12].x;
DP4 R0.x, vertex.position, c[1];
RCP R0.w, R0.w;
RCP R0.y, R0.y;
MAD R0.y, -R0.w, c[12], R0;
MIN R0.y, R0, c[12].x;
MAX R1.w, R0.y, c[0];
MAX R0.z, R0, c[0].w;
MUL result.texcoord[0].x, R0.z, R1.w;
DP4 R0.w, vertex.position, c[4];
DP4 R0.y, vertex.position, c[2];
DP4 R0.z, vertex.position, c[3];
MUL R1.xyz, R0.xyww, c[12].z;
MUL R1.y, R1, c[10].x;
ADD result.texcoord[4].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[11].w;
MOV result.position, R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[0].w;
END
# 44 instructions, 3 R-regs
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float tmpvar_28;
  mediump float lightShadowDataX_29;
  highp float dist_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = _LightShadowData.x;
  lightShadowDataX_29 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = max (float((dist_30 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_29);
  tmpvar_28 = tmpvar_33;
  mediump vec4 tmpvar_34;
  mediump vec3 lightDir_35;
  lightDir_35 = _WorldSpaceLightPos0.xyz;
  mediump float atten_36;
  atten_36 = tmpvar_28;
  lowp vec4 c_37;
  highp float lightIntensity_38;
  mediump float tmpvar_39;
  tmpvar_39 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_35) - 0.01) / 0.99) * atten_36) * 16.0));
  lightIntensity_38 = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_3 * (1.0 - clamp (lightIntensity_38, 0.0, 1.0)));
  c_37.w = tmpvar_40;
  c_37.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_34 = c_37;
  c_1 = tmpvar_34;
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float tmpvar_28;
  tmpvar_28 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  mediump vec4 tmpvar_29;
  mediump vec3 lightDir_30;
  lightDir_30 = _WorldSpaceLightPos0.xyz;
  mediump float atten_31;
  atten_31 = tmpvar_28;
  lowp vec4 c_32;
  highp float lightIntensity_33;
  mediump float tmpvar_34;
  tmpvar_34 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_30) - 0.01) / 0.99) * atten_31) * 16.0));
  lightIntensity_33 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_3 * (1.0 - clamp (lightIntensity_33, 0.0, 1.0)));
  c_32.w = tmpvar_35;
  c_32.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_29 = c_32;
  c_1 = tmpvar_29;
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
#line 449
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
#line 459
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
#line 459
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 463
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 467
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 472
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
#line 449
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
#line 459
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 434
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 438
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 442
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 446
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 474
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 476
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 480
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 484
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 488
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 492
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump vec4 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = _WorldSpaceLightPos0.xyz;
  mediump float atten_33;
  atten_33 = shadow_28;
  lowp vec4 c_34;
  highp float lightIntensity_35;
  mediump float tmpvar_36;
  tmpvar_36 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_32) - 0.01) / 0.99) * atten_33) * 16.0));
  lightIntensity_35 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_3 * (1.0 - clamp (lightIntensity_35, 0.0, 1.0)));
  c_34.w = tmpvar_37;
  c_34.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_31 = c_34;
  c_1 = tmpvar_31;
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
#line 449
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
#line 459
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
#line 459
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 463
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 467
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 472
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
#line 449
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
#line 459
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 434
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 438
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 442
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 446
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 474
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 476
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 480
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 484
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 488
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 492
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
    highp float s_12;
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
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, uv_9) * _Color);
  main_8 = tmpvar_15;
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = ((xlv_TEXCOORD1.zy * _DetailScale) + _DetailOffset.xy);
  tmpvar_16 = texture2D (_DetailTex, P_17);
  detailX_7 = tmpvar_16;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD1.zx * _DetailScale) + _DetailOffset.xy);
  tmpvar_18 = texture2D (_DetailTex, P_19);
  detailY_6 = tmpvar_18;
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = ((xlv_TEXCOORD1.xy * _DetailScale) + _DetailOffset.xy);
  tmpvar_20 = texture2D (_DetailTex, P_21);
  detailZ_5 = tmpvar_20;
  highp vec3 tmpvar_22;
  tmpvar_22 = abs(xlv_TEXCOORD1);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (detailZ_5, detailX_7, tmpvar_22.xxxx);
  detail_4 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = mix (detail_4, detailY_6, tmpvar_22.yyyy);
  detail_4 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (main_8 * detail_4);
  main_8 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = min (tmpvar_25.w, xlv_TEXCOORD0);
  tmpvar_3 = tmpvar_26;
  mediump vec3 tmpvar_27;
  tmpvar_27 = tmpvar_25.xyz;
  tmpvar_2 = tmpvar_27;
  lowp float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (tmpvar_29 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  mediump vec4 tmpvar_31;
  mediump vec3 lightDir_32;
  lightDir_32 = _WorldSpaceLightPos0.xyz;
  mediump float atten_33;
  atten_33 = shadow_28;
  lowp vec4 c_34;
  highp float lightIntensity_35;
  mediump float tmpvar_36;
  tmpvar_36 = (_LightColor0.w * ((((dot (xlv_TEXCOORD2, lightDir_32) - 0.01) / 0.99) * atten_33) * 16.0));
  lightIntensity_35 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_3 * (1.0 - clamp (lightIntensity_35, 0.0, 1.0)));
  c_34.w = tmpvar_37;
  c_34.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_31 = c_34;
  c_1 = tmpvar_31;
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
#line 449
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
#line 459
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
#line 459
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    Input customInputData;
    #line 463
    vert( v, customInputData);
    o.cust_distAlpha = customInputData.distAlpha;
    o.cust_localPos = customInputData.localPos;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 467
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    o.vlight = vec3( 0.0);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 472
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
#line 449
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
#line 459
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
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 434
    highp vec3 pos = IN.localPos;
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( pos.z, pos.x)));
    uv.y = (0.31831 * acos((-pos.y)));
    #line 438
    mediump vec4 main = (texture( _MainTex, uv) * _Color);
    mediump vec4 detailX = texture( _DetailTex, ((pos.zy * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailY = texture( _DetailTex, ((pos.zx * _DetailScale) + _DetailOffset.xy));
    mediump vec4 detailZ = texture( _DetailTex, ((pos.xy * _DetailScale) + _DetailOffset.xy));
    #line 442
    pos = abs(pos);
    mediump vec4 detail = mix( detailZ, detailX, vec4( pos.x));
    detail = mix( detail, detailY, vec4( pos.y));
    main = (main * detail);
    #line 446
    o.Alpha = min( main.w, IN.distAlpha);
    o.Emission = main.xyz;
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 474
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 476
    Input surfIN;
    surfIN.distAlpha = IN.cust_distAlpha;
    surfIN.localPos = IN.cust_localPos;
    SurfaceOutput o;
    #line 480
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 484
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 488
    lowp vec4 c = vec4( 0.0);
    c = LightingNone( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 492
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
//   opengl - ALU: 57 to 59, TEX: 4 to 5
//   d3d9 - ALU: 53 to 54, TEX: 4 to 5
//   d3d11 - ALU: 49 to 52, TEX: 4 to 5, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_Color]
Vector 4 [_DetailOffset]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"3.0-!!ARBfp1.0
# 57 ALU, 4 TEX
PARAM c[11] = { program.local[0..4],
		{ 0, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1, 2 },
		{ 0.31830987, -0.01348047, 0.05747731, 0.1212391 },
		{ 0.1956359, 0.33299461, 0.99999559, 1.570796 },
		{ 0.15915494, 0.5, 0.010002136 },
		{ 16.157791, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[1].zyzw, c[2].x;
ADD R0.xy, R0, c[4];
MUL R1.xy, fragment.texcoord[1], c[2].x;
ABS R2.xy, fragment.texcoord[1];
ABS R2.z, fragment.texcoord[1];
MAX R1.z, R2, R2.x;
RCP R1.w, R1.z;
MIN R1.z, R2, R2.x;
MUL R2.w, R1.z, R1;
MUL R3.x, R2.w, R2.w;
MAD R3.y, R3.x, c[7], c[7].z;
ADD R1.xy, R1, c[4];
TEX R1, R1, texture[1], 2D;
TEX R0, R0, texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, R2.x, R0, R1;
MAD R3.y, R3, R3.x, -c[7].w;
MAD R0.z, R3.y, R3.x, c[8].x;
MAD R0.z, R0, R3.x, -c[8].y;
MAD R3.x, R0.z, R3, c[8].z;
MUL R0.xy, fragment.texcoord[1].zxzw, c[2].x;
ADD R0.xy, R0, c[4];
TEX R0, R0, texture[1], 2D;
ADD R0, R0, -R1;
MAD R0, R2.y, R0, R1;
MUL R2.w, R3.x, R2;
ADD R1.x, R2.z, -R2;
ADD R1.y, -R2.w, c[8].w;
CMP R1.w, -R1.x, R1.y, R2;
ABS R1.x, -fragment.texcoord[1].y;
ADD R2.x, -R1.w, c[5].y;
CMP R1.w, fragment.texcoord[1].x, R2.x, R1;
ADD R1.z, -R1.x, c[6];
MAD R1.y, R1.x, c[5].z, c[5].w;
MAD R1.y, R1, R1.x, -c[6].x;
RSQ R1.z, R1.z;
DP3 R2.x, fragment.texcoord[2], c[0];
ADD R2.x, R2, -c[9].z;
MAD R1.x, R1.y, R1, c[6].y;
RCP R1.z, R1.z;
MUL R1.y, R1.x, R1.z;
SLT R1.x, -fragment.texcoord[1].y, c[5];
MUL R1.z, R1.x, R1.y;
MAD R1.y, -R1.z, c[6].w, R1;
MAD R1.y, R1.x, c[5], R1;
CMP R1.z, fragment.texcoord[1], -R1.w, R1.w;
MAD R1.x, R1.z, c[9], c[9].y;
MUL R1.y, R1, c[7].x;
TEX R1, R1, texture[0], 2D;
MUL R1, R1, c[3];
MUL R0, R1, R0;
MOV result.color.xyz, R0;
MUL R2.x, R2, c[1].w;
MUL_SAT R1.x, R2, c[10];
ADD R0.y, -R1.x, c[6].z;
MIN R0.x, R0.w, fragment.texcoord[0];
MUL result.color.w, R0.x, R0.y;
END
# 57 instructions, 4 R-regs
"
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
; 53 ALU, 4 TEX
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
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c4
mul r1.xy, v1, c2.x
abs r2.xy, v1
abs r2.z, v1
max r1.z, r2, r2.x
rcp r1.w, r1.z
min r1.z, r2, r2.x
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c7, c7.z
add r1.xy, r1, c4
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r3.y, r3, r3.x, c7.w
mad r0.z, r3.y, r3.x, c8.x
mad r0.z, r0, r3.x, c8.y
mad r3.x, r0.z, r3, c8.z
mul r0.xy, v1.zxzw, c2.x
add r0.xy, r0, c4
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mul r2.w, r3.x, r2
add r1.x, r2.z, -r2
add r1.y, -r2.w, c8.w
cmp r1.w, -r1.x, r2, r1.y
abs r1.x, -v1.y
add r2.x, -r1.w, c6.w
cmp r1.w, v1.x, r1, r2.x
add r1.z, -r1.x, c5.y
mad r1.y, r1.x, c5.z, c5.w
mad r1.y, r1, r1.x, c6.x
rsq r1.z, r1.z
dp3_pp r2.x, v2, c0
add_pp r2.x, r2, c9.z
mad r1.x, r1.y, r1, c6.y
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, -v1.y, c5, c5.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c6.z, r1
mad r1.y, r1.x, c6.w, r1
cmp r1.z, v1, r1.w, -r1.w
mad r1.x, r1.z, c9, c9.y
mul r1.y, r1, c7.x
texld r1, r1, s0
mul r1, r1, c3
mul_pp r0, r1, r0
mov_pp oC0.xyz, r0
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
// 56 instructions, 4 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 4 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgofccjcaednineobohnlfmaokeaecglfabaaaaaaliaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclaahaaaaeaaaaaaaomabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaa
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
ccaabaaaaaaaaaaabkbabaaaabaaaaaabkbabaiaebaaaaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaa
bkbabaaaabaaaaaadkbabaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaabkbabaaa
abaaaaaadkbabaaaabaaaaaabnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
ckbabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackbabaiaibaaaaaaabaaaaaaabeaaaaa
iedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackbabaiaibaaaaaa
abaaaaaaabeaaaaakeanmjdpaaaaaaaiicaabaaaaaaaaaaackbabaiambaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
dbaaaaaiccaabaaaabaaaaaackbabaiaebaaaaaaabaaaaaackbabaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaalpcaabaaaabaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaa
egiecaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaldcaabaaaadaaaaaa
jgbfbaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibebdicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_DetailScale]
Vector 3 [_Color]
Vector 4 [_DetailOffset]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 59 ALU, 5 TEX
PARAM c[11] = { program.local[0..4],
		{ 0, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 1, 2 },
		{ 0.31830987, -0.01348047, 0.05747731, 0.1212391 },
		{ 0.1956359, 0.33299461, 0.99999559, 1.570796 },
		{ 0.15915494, 0.5, 0.010002136 },
		{ 16.157791, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xy, fragment.texcoord[1].zyzw, c[2].x;
ADD R0.xy, R0, c[4];
MUL R1.xy, fragment.texcoord[1], c[2].x;
ABS R2.xy, fragment.texcoord[1];
ABS R2.z, fragment.texcoord[1];
MAX R1.z, R2, R2.x;
RCP R1.w, R1.z;
MIN R1.z, R2, R2.x;
MUL R2.w, R1.z, R1;
MUL R3.x, R2.w, R2.w;
MAD R3.y, R3.x, c[7], c[7].z;
ADD R1.xy, R1, c[4];
TEX R1, R1, texture[1], 2D;
TEX R0, R0, texture[1], 2D;
ADD R0, R0, -R1;
MAD R1, R2.x, R0, R1;
MAD R3.y, R3, R3.x, -c[7].w;
MAD R0.z, R3.y, R3.x, c[8].x;
MAD R0.z, R0, R3.x, -c[8].y;
MAD R3.x, R0.z, R3, c[8].z;
MUL R0.xy, fragment.texcoord[1].zxzw, c[2].x;
ADD R0.xy, R0, c[4];
TEX R0, R0, texture[1], 2D;
ADD R0, R0, -R1;
MAD R0, R2.y, R0, R1;
MUL R2.w, R3.x, R2;
DP3 R2.y, fragment.texcoord[2], c[0];
ADD R1.x, R2.z, -R2;
ADD R1.y, -R2.w, c[8].w;
CMP R1.w, -R1.x, R1.y, R2;
ABS R1.x, -fragment.texcoord[1].y;
ADD R2.x, -R1.w, c[5].y;
CMP R1.w, fragment.texcoord[1].x, R2.x, R1;
ADD R1.z, -R1.x, c[6];
MAD R1.y, R1.x, c[5].z, c[5].w;
MAD R1.y, R1, R1.x, -c[6].x;
RSQ R1.z, R1.z;
MAD R1.x, R1.y, R1, c[6].y;
RCP R1.z, R1.z;
MUL R1.y, R1.x, R1.z;
SLT R1.x, -fragment.texcoord[1].y, c[5];
MUL R1.z, R1.x, R1.y;
MAD R1.y, -R1.z, c[6].w, R1;
MAD R1.y, R1.x, c[5], R1;
CMP R1.z, fragment.texcoord[1], -R1.w, R1.w;
MAD R1.x, R1.z, c[9], c[9].y;
MUL R1.y, R1, c[7].x;
TEX R1, R1, texture[0], 2D;
MUL R1, R1, c[3];
MUL R0, R1, R0;
MOV result.color.xyz, R0;
TXP R2.x, fragment.texcoord[4], texture[2], 2D;
ADD R2.y, R2, -c[9].z;
MUL R2.x, R2.y, R2;
MUL R2.x, R2, c[1].w;
MUL_SAT R1.x, R2, c[10];
ADD R0.y, -R1.x, c[6].z;
MIN R0.x, R0.w, fragment.texcoord[0];
MUL result.color.w, R0.x, R0.y;
END
# 59 instructions, 4 R-regs
"
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
; 54 ALU, 5 TEX
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
mul r0.xy, v1.zyzw, c2.x
add r0.xy, r0, c4
mul r1.xy, v1, c2.x
abs r2.xy, v1
abs r2.z, v1
max r1.z, r2, r2.x
rcp r1.w, r1.z
min r1.z, r2, r2.x
mul r2.w, r1.z, r1
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c7, c7.z
add r1.xy, r1, c4
texld r1, r1, s1
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r1, r2.x, r0, r1
mad r3.y, r3, r3.x, c7.w
mad r0.z, r3.y, r3.x, c8.x
mad r0.z, r0, r3.x, c8.y
mad r3.x, r0.z, r3, c8.z
mul r0.xy, v1.zxzw, c2.x
add r0.xy, r0, c4
texld r0, r0, s1
add_pp r0, r0, -r1
mad_pp r0, r2.y, r0, r1
mul r2.w, r3.x, r2
dp3_pp r2.y, v2, c0
add r1.x, r2.z, -r2
add r1.y, -r2.w, c8.w
cmp r1.w, -r1.x, r2, r1.y
abs r1.x, -v1.y
add r2.x, -r1.w, c6.w
cmp r1.w, v1.x, r1, r2.x
add r1.z, -r1.x, c5.y
mad r1.y, r1.x, c5.z, c5.w
mad r1.y, r1, r1.x, c6.x
rsq r1.z, r1.z
mad r1.x, r1.y, r1, c6.y
rcp r1.z, r1.z
mul r1.y, r1.x, r1.z
cmp r1.x, -v1.y, c5, c5.y
mul r1.z, r1.x, r1.y
mad r1.y, -r1.z, c6.z, r1
mad r1.y, r1.x, c6.w, r1
cmp r1.z, v1, r1.w, -r1.w
mad r1.x, r1.z, c9, c9.y
mul r1.y, r1, c7.x
texld r1, r1, s0
mul r1, r1, c3
mul_pp r0, r1, r0
mov_pp oC0.xyz, r0
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
// 60 instructions, 4 temp regs, 0 temp arrays:
// ALU 48 float, 0 int, 4 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddkfkillkbhfllmgdjhelahjloaieebppabaaaaaahaajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaababaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aoaoaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaaiaaaa
eaaaaaaabeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaa
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
ccaabaaaaaaaaaaabkbabaaaabaaaaaabkbabaiaebaaaaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaanlapejmaaaaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaa
bkbabaaaabaaaaaadkbabaaaabaaaaaadbaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaabkbabaaa
abaaaaaadkbabaaaabaaaaaabnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
ckbabaiaibaaaaaaabaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaackbabaiaibaaaaaaabaaaaaaabeaaaaa
iedefjlodcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaackbabaiaibaaaaaa
abaaaaaaabeaaaaakeanmjdpaaaaaaaiicaabaaaaaaaaaaackbabaiambaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
dbaaaaaiccaabaaaabaaaaaackbabaiaebaaaaaaabaaaaaackbabaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaaiaaaaaa
dcaaaaalpcaabaaaabaaaaaalgbhbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
egiecaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaldcaabaaaadaaaaaa
jgbfbaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaa
adaaaaaadcaaaaakpcaabaaaacaaaaaafgbfbaiaibaaaaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaiaebaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaakgbkbaiaibaaaaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakbabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaapnekibdpaoaaaaahgcaabaaa
aaaaaaaaagbbbaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
jgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaadicaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaebaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
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

#LINE 82

	 	 
	 } 
    }
}