Shader "EVE/CloudShadow" {
   Properties {
      _MainTex ("Main (RGB)", 2D) = "white" {}
      _DetailTex ("Detail (RGB)", 2D) = "white" {}
      _DetailScale ("Detail Scale", float) = 100
      _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
	  _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	  _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
	  _Radius ("Radius", Float) = 1
	  _PlanetRadius ("Planet Radius", Float) = 1
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        ZWrite Off
        Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 41 to 41
//   d3d11 - ALU: 36 to 36, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;
uniform vec3 _PlanetOrigin;
uniform float _Radius;
uniform vec4 _SunDir;
uniform mat4 _DetailRotation;
uniform mat4 _MainRotation;
uniform mat4 _Object2World;

void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_PlanetOrigin - tmpvar_1.xyz);
  float tmpvar_3;
  tmpvar_3 = dot (tmpvar_2, -(_SunDir).xyz);
  float tmpvar_4;
  tmpvar_4 = sqrt((dot (tmpvar_2, tmpvar_2) - (tmpvar_3 * tmpvar_3)));
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 + (_SunDir * mix (0.0, (tmpvar_3 - sqrt(((_Radius * _Radius) - pow (tmpvar_4, 2.0)))), (float((_Radius >= tmpvar_4)) * float((tmpvar_3 >= 0.0))))));
  vec4 tmpvar_6;
  tmpvar_6 = -((_MainRotation * tmpvar_5));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_2, tmpvar_2));
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_6);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _PlanetRadius;
uniform float _Radius;
uniform float _DetailDist;
uniform float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 color_1;
  vec4 main_2;
  float shadowCheck_3;
  shadowCheck_3 = (((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2))) * float(((xlv_TEXCOORD2 + 5.0) >= _PlanetRadius)));
  vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD4.xyz);
  vec2 uv_5;
  float r_6;
  if ((abs(tmpvar_4.z) > (1e-08 * abs(tmpvar_4.x)))) {
    float y_over_x_7;
    y_over_x_7 = (tmpvar_4.x / tmpvar_4.z);
    float s_8;
    float x_9;
    x_9 = (y_over_x_7 * inversesqrt(((y_over_x_7 * y_over_x_7) + 1.0)));
    s_8 = (sign(x_9) * (1.5708 - (sqrt((1.0 - abs(x_9))) * (1.5708 + (abs(x_9) * (-0.214602 + (abs(x_9) * (0.0865667 + (abs(x_9) * -0.0310296)))))))));
    r_6 = s_8;
    if ((tmpvar_4.z < 0.0)) {
      if ((tmpvar_4.x >= 0.0)) {
        r_6 = (s_8 + 3.14159);
      } else {
        r_6 = (r_6 - 3.14159);
      };
    };
  } else {
    r_6 = (sign(tmpvar_4.x) * 1.5708);
  };
  uv_5.x = (0.5 + (0.159155 * r_6));
  uv_5.y = (0.31831 * (1.5708 - (sign(tmpvar_4.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_4.y))) * (1.5708 + (abs(tmpvar_4.y) * (-0.214602 + (abs(tmpvar_4.y) * (0.0865667 + (abs(tmpvar_4.y) * -0.0310296)))))))))));
  vec2 tmpvar_10;
  tmpvar_10 = dFdx(tmpvar_4.xz);
  vec2 tmpvar_11;
  tmpvar_11 = dFdy(tmpvar_4.xz);
  vec4 tmpvar_12;
  tmpvar_12.x = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_12.y = dFdx(uv_5.y);
  tmpvar_12.z = (0.159155 * sqrt(dot (tmpvar_11, tmpvar_11)));
  tmpvar_12.w = dFdy(uv_5.y);
  main_2 = texture2DGradARB (_MainTex, uv_5, tmpvar_12.xy, tmpvar_12.zw);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD5.xyz);
  vec2 uv_14;
  float r_15;
  if ((abs(tmpvar_13.z) > (1e-08 * abs(tmpvar_13.x)))) {
    float y_over_x_16;
    y_over_x_16 = (tmpvar_13.x / tmpvar_13.z);
    float s_17;
    float x_18;
    x_18 = (y_over_x_16 * inversesqrt(((y_over_x_16 * y_over_x_16) + 1.0)));
    s_17 = (sign(x_18) * (1.5708 - (sqrt((1.0 - abs(x_18))) * (1.5708 + (abs(x_18) * (-0.214602 + (abs(x_18) * (0.0865667 + (abs(x_18) * -0.0310296)))))))));
    r_15 = s_17;
    if ((tmpvar_13.z < 0.0)) {
      if ((tmpvar_13.x >= 0.0)) {
        r_15 = (s_17 + 3.14159);
      } else {
        r_15 = (r_15 - 3.14159);
      };
    };
  } else {
    r_15 = (sign(tmpvar_13.x) * 1.5708);
  };
  uv_14.x = (0.5 + (0.159155 * r_15));
  uv_14.y = (0.31831 * (1.5708 - (sign(tmpvar_13.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_13.y))) * (1.5708 + (abs(tmpvar_13.y) * (-0.214602 + (abs(tmpvar_13.y) * (0.0865667 + (abs(tmpvar_13.y) * -0.0310296)))))))))));
  vec2 tmpvar_19;
  tmpvar_19 = ((uv_14 * 4.0) * _DetailScale);
  vec2 tmpvar_20;
  tmpvar_20 = dFdx(tmpvar_13.xz);
  vec2 tmpvar_21;
  tmpvar_21 = dFdy(tmpvar_13.xz);
  vec4 tmpvar_22;
  tmpvar_22.x = (0.159155 * sqrt(dot (tmpvar_20, tmpvar_20)));
  tmpvar_22.y = dFdx(tmpvar_19.y);
  tmpvar_22.z = (0.159155 * sqrt(dot (tmpvar_21, tmpvar_21)));
  tmpvar_22.w = dFdy(tmpvar_19.y);
  vec3 tmpvar_23;
  tmpvar_23 = abs(tmpvar_13);
  float tmpvar_24;
  tmpvar_24 = float((tmpvar_23.z >= tmpvar_23.x));
  vec3 tmpvar_25;
  tmpvar_25 = mix (tmpvar_23.yxz, mix (tmpvar_23, tmpvar_23.zxy, vec3(tmpvar_24)), vec3(float((mix (tmpvar_23.x, tmpvar_23.z, tmpvar_24) >= tmpvar_23.y))));
  vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = _WorldSpaceCameraPos;
  vec4 p_27;
  p_27 = (xlv_TEXCOORD3 - tmpvar_26);
  vec4 tmpvar_28;
  tmpvar_28 = (main_2 * mix (texture2DGradARB (_DetailTex, (((0.5 * tmpvar_25.zy) / abs(tmpvar_25.x)) * _DetailScale), tmpvar_22.xy, tmpvar_22.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (((2.0 * _DetailDist) * sqrt(dot (p_27, p_27))), 0.0, 1.0))));
  color_1.xyz = tmpvar_28.xyz;
  color_1.w = (1.2 * (1.2 - tmpvar_28.w));
  vec4 tmpvar_29;
  tmpvar_29 = clamp (color_1, 0.0, 1.0);
  color_1 = tmpvar_29;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_29.w, shadowCheck_3));
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_MainRotation]
Matrix 12 [_DetailRotation]
Vector 20 [_SunDir]
Float 21 [_Radius]
Vector 22 [_PlanetOrigin]
Matrix 16 [_Projector]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 0.00000000, 0, 0, 0
dcl_position0 v0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r1.xyz, -r0, c22
dp3 r2.x, r1, -c20
dp3 r2.y, r1, r1
mad r0.w, -r2.x, r2.x, r2.y
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r1.x, r0.w, r0.w
mad r1.x, c21, c21, -r1
rsq r1.x, r1.x
rcp r1.y, r1.x
sge r0.w, c21.x, r0
sge r1.x, r2, c23
mul r1.x, r0.w, r1
add r1.y, r2.x, -r1
dp4 r0.w, v0, c7
mul r1.x, r1, r1.y
mad r1, r1.x, c20, r0
dp4 r0.x, r1, c8
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
mov o5, -r0
dp4 o6.w, -r0, c15
dp4 o6.z, -r0, c14
dp4 o6.y, -r0, c13
dp4 o6.x, -r0, c12
rsq r0.x, r2.y
mov o4, r1
mov o2.x, r2
rcp o3.x, r0.x
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c19
dp4 o1.z, v0, c18
dp4 o1.y, v0, c17
dp4 o1.x, v0, c16
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
ConstBuffer "$Globals" 304 // 304 used size, 12 vars
Matrix 16 [_MainRotation] 4
Matrix 80 [_DetailRotation] 4
Vector 192 [_SunDir] 4
Float 208 [_Radius]
Vector 224 [_PlanetOrigin] 3
Matrix 240 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 40 instructions, 2 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddnplcjkbnjmalhhdpodendlbngdcgjdoabaaaaaacmahaaaaadaaaaaa
cmaaaaaahmaaaaaaemabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcniafaaaaeaaaabaahgabaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadbccabaaaacaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaapaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaa
aaaaaaaabcaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaabaaaaaajbcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaamaaaaaaelaaaaafcccabaaaacaaaaaa
dkaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadgaaaaafbccabaaaacaaaaaaakaabaaaabaaaaaabnaaaaahecaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaabnaaaaaiicaabaaaabaaaaaa
akiacaaaaaaaaaaaanaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaamccaabaaaabaaaaaaakiacaaa
aaaaaaaaanaaaaaaakiacaaaaaaaaaaaanaaaaaabkaabaiaebaaaaaaabaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaaabaaaaakgcaabaaaabaaaaaa
pgaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaamaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadgaaaaagpccabaaaaeaaaaaaegaobaiaebaaaaaaaaaaaaaa
diaaaaajpcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaaegiocaaaaaaaaaaa
agaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaaagaabaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaakgakbaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaal
pccabaaaafaaaaaaegiocaaaaaaaaaaaaiaaaaaapgapbaiaebaaaaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Radius;
uniform highp vec4 _SunDir;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesVertex;
void main ()
{
  mediump float sphereCheck_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  highp float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, -(_SunDir).xyz);
  highp float tmpvar_5;
  tmpvar_5 = sqrt((dot (tmpvar_3, tmpvar_3) - (tmpvar_4 * tmpvar_4)));
  highp float tmpvar_6;
  tmpvar_6 = (float((_Radius >= tmpvar_5)) * float((tmpvar_4 >= 0.0)));
  sphereCheck_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 + (_SunDir * mix (0.0, (tmpvar_4 - sqrt(((_Radius * _Radius) - pow (tmpvar_5, 2.0)))), sphereCheck_1)));
  highp vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * tmpvar_7));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _PlanetRadius;
uniform highp float _Radius;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float detailLevel_3;
  mediump float shadowCheck_4;
  highp float tmpvar_5;
  tmpvar_5 = ((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2)));
  shadowCheck_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (shadowCheck_4 * float(((xlv_TEXCOORD2 + 5.0) >= _PlanetRadius)));
  shadowCheck_4 = tmpvar_6;
  mediump vec4 tex_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(tmpvar_8.z) > (1e-08 * abs(tmpvar_8.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (tmpvar_8.x / tmpvar_8.z);
    highp float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((tmpvar_8.z < 0.0)) {
      if ((tmpvar_8.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(tmpvar_8.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(tmpvar_8.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_8.y))) * (1.5708 + (abs(tmpvar_8.y) * (-0.214602 + (abs(tmpvar_8.y) * (0.0865667 + (abs(tmpvar_8.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_14;
  tmpvar_14 = dFdx(tmpvar_8.xz);
  highp vec2 tmpvar_15;
  tmpvar_15 = dFdy(tmpvar_8.xz);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_16.y = dFdx(uv_9.y);
  tmpvar_16.z = (0.159155 * sqrt(dot (tmpvar_15, tmpvar_15)));
  tmpvar_16.w = dFdy(uv_9.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DGradEXT (_MainTex, uv_9, tmpvar_16.xy, tmpvar_16.zw);
  tex_7 = tmpvar_17;
  mediump vec4 tmpvar_18;
  mediump vec3 detailCoords_19;
  mediump float nylerp_20;
  mediump float zxlerp_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_23;
  highp float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    highp float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_23 * 4.0) * _DetailScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(tmpvar_22.xz);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(tmpvar_22.xz);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28.y);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28.y);
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(tmpvar_22);
  highp float tmpvar_33;
  tmpvar_33 = float((tmpvar_32.z >= tmpvar_32.x));
  zxlerp_21 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = float((mix (tmpvar_32.x, tmpvar_32.z, zxlerp_21) >= tmpvar_32.y));
  nylerp_20 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (tmpvar_32, tmpvar_32.zxy, vec3(zxlerp_21));
  detailCoords_19 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_32.yxz, detailCoords_19, vec3(nylerp_20));
  detailCoords_19 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(detailCoords_19.x);
  highp vec2 coord_38;
  coord_38 = (((0.5 * detailCoords_19.zy) / tmpvar_37) * _DetailScale);
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DGradEXT (_DetailTex, coord_38, tmpvar_31.xy, tmpvar_31.zw);
  tmpvar_18 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (xlv_TEXCOORD3 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_41, p_41))), 0.0, 1.0);
  detailLevel_3 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (tex_7 * mix (tmpvar_18, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_3)));
  color_2 = tmpvar_43;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_44;
  tmpvar_44 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45 = vec4(mix (1.0, tmpvar_44.w, shadowCheck_4));
  tmpvar_1 = tmpvar_45;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Radius;
uniform highp vec4 _SunDir;
uniform highp mat4 _DetailRotation;
uniform highp mat4 _MainRotation;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesVertex;
void main ()
{
  mediump float sphereCheck_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  highp float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, -(_SunDir).xyz);
  highp float tmpvar_5;
  tmpvar_5 = sqrt((dot (tmpvar_3, tmpvar_3) - (tmpvar_4 * tmpvar_4)));
  highp float tmpvar_6;
  tmpvar_6 = (float((_Radius >= tmpvar_5)) * float((tmpvar_4 >= 0.0)));
  sphereCheck_1 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_2 + (_SunDir * mix (0.0, (tmpvar_4 - sqrt(((_Radius * _Radius) - pow (tmpvar_5, 2.0)))), sphereCheck_1)));
  highp vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * tmpvar_7));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _PlanetRadius;
uniform highp float _Radius;
uniform highp float _DetailDist;
uniform highp float _DetailScale;
uniform sampler2D _DetailTex;
uniform sampler2D _MainTex;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float detailLevel_3;
  mediump float shadowCheck_4;
  highp float tmpvar_5;
  tmpvar_5 = ((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2)));
  shadowCheck_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (shadowCheck_4 * float(((xlv_TEXCOORD2 + 5.0) >= _PlanetRadius)));
  shadowCheck_4 = tmpvar_6;
  mediump vec4 tex_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_9;
  highp float r_10;
  if ((abs(tmpvar_8.z) > (1e-08 * abs(tmpvar_8.x)))) {
    highp float y_over_x_11;
    y_over_x_11 = (tmpvar_8.x / tmpvar_8.z);
    highp float s_12;
    highp float x_13;
    x_13 = (y_over_x_11 * inversesqrt(((y_over_x_11 * y_over_x_11) + 1.0)));
    s_12 = (sign(x_13) * (1.5708 - (sqrt((1.0 - abs(x_13))) * (1.5708 + (abs(x_13) * (-0.214602 + (abs(x_13) * (0.0865667 + (abs(x_13) * -0.0310296)))))))));
    r_10 = s_12;
    if ((tmpvar_8.z < 0.0)) {
      if ((tmpvar_8.x >= 0.0)) {
        r_10 = (s_12 + 3.14159);
      } else {
        r_10 = (r_10 - 3.14159);
      };
    };
  } else {
    r_10 = (sign(tmpvar_8.x) * 1.5708);
  };
  uv_9.x = (0.5 + (0.159155 * r_10));
  uv_9.y = (0.31831 * (1.5708 - (sign(tmpvar_8.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_8.y))) * (1.5708 + (abs(tmpvar_8.y) * (-0.214602 + (abs(tmpvar_8.y) * (0.0865667 + (abs(tmpvar_8.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_14;
  tmpvar_14 = dFdx(tmpvar_8.xz);
  highp vec2 tmpvar_15;
  tmpvar_15 = dFdy(tmpvar_8.xz);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (0.159155 * sqrt(dot (tmpvar_14, tmpvar_14)));
  tmpvar_16.y = dFdx(uv_9.y);
  tmpvar_16.z = (0.159155 * sqrt(dot (tmpvar_15, tmpvar_15)));
  tmpvar_16.w = dFdy(uv_9.y);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DGradEXT (_MainTex, uv_9, tmpvar_16.xy, tmpvar_16.zw);
  tex_7 = tmpvar_17;
  mediump vec4 tmpvar_18;
  mediump vec3 detailCoords_19;
  mediump float nylerp_20;
  mediump float zxlerp_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_23;
  highp float r_24;
  if ((abs(tmpvar_22.z) > (1e-08 * abs(tmpvar_22.x)))) {
    highp float y_over_x_25;
    y_over_x_25 = (tmpvar_22.x / tmpvar_22.z);
    highp float s_26;
    highp float x_27;
    x_27 = (y_over_x_25 * inversesqrt(((y_over_x_25 * y_over_x_25) + 1.0)));
    s_26 = (sign(x_27) * (1.5708 - (sqrt((1.0 - abs(x_27))) * (1.5708 + (abs(x_27) * (-0.214602 + (abs(x_27) * (0.0865667 + (abs(x_27) * -0.0310296)))))))));
    r_24 = s_26;
    if ((tmpvar_22.z < 0.0)) {
      if ((tmpvar_22.x >= 0.0)) {
        r_24 = (s_26 + 3.14159);
      } else {
        r_24 = (r_24 - 3.14159);
      };
    };
  } else {
    r_24 = (sign(tmpvar_22.x) * 1.5708);
  };
  uv_23.x = (0.5 + (0.159155 * r_24));
  uv_23.y = (0.31831 * (1.5708 - (sign(tmpvar_22.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_22.y))) * (1.5708 + (abs(tmpvar_22.y) * (-0.214602 + (abs(tmpvar_22.y) * (0.0865667 + (abs(tmpvar_22.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_28;
  tmpvar_28 = ((uv_23 * 4.0) * _DetailScale);
  highp vec2 tmpvar_29;
  tmpvar_29 = dFdx(tmpvar_22.xz);
  highp vec2 tmpvar_30;
  tmpvar_30 = dFdy(tmpvar_22.xz);
  highp vec4 tmpvar_31;
  tmpvar_31.x = (0.159155 * sqrt(dot (tmpvar_29, tmpvar_29)));
  tmpvar_31.y = dFdx(tmpvar_28.y);
  tmpvar_31.z = (0.159155 * sqrt(dot (tmpvar_30, tmpvar_30)));
  tmpvar_31.w = dFdy(tmpvar_28.y);
  highp vec3 tmpvar_32;
  tmpvar_32 = abs(tmpvar_22);
  highp float tmpvar_33;
  tmpvar_33 = float((tmpvar_32.z >= tmpvar_32.x));
  zxlerp_21 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = float((mix (tmpvar_32.x, tmpvar_32.z, zxlerp_21) >= tmpvar_32.y));
  nylerp_20 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (tmpvar_32, tmpvar_32.zxy, vec3(zxlerp_21));
  detailCoords_19 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (tmpvar_32.yxz, detailCoords_19, vec3(nylerp_20));
  detailCoords_19 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = abs(detailCoords_19.x);
  highp vec2 coord_38;
  coord_38 = (((0.5 * detailCoords_19.zy) / tmpvar_37) * _DetailScale);
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DGradEXT (_DetailTex, coord_38, tmpvar_31.xy, tmpvar_31.zw);
  tmpvar_18 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40.w = 0.0;
  tmpvar_40.xyz = _WorldSpaceCameraPos;
  highp vec4 p_41;
  p_41 = (xlv_TEXCOORD3 - tmpvar_40);
  highp float tmpvar_42;
  tmpvar_42 = clamp (((2.0 * _DetailDist) * sqrt(dot (p_41, p_41))), 0.0, 1.0);
  detailLevel_3 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = (tex_7 * mix (tmpvar_18, vec4(1.0, 1.0, 1.0, 1.0), vec4(detailLevel_3)));
  color_2 = tmpvar_43;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_44;
  tmpvar_44 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45 = vec4(mix (1.0, tmpvar_44.w, shadowCheck_4));
  tmpvar_1 = tmpvar_45;
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
#line 403
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    highp float originDist;
    highp vec4 worldPos;
    highp vec4 mainPos;
    highp vec4 detailPos;
};
#line 397
struct appdata_t {
    highp vec4 vertex;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 390
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
#line 394
uniform highp float _PlanetRadius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 414
#line 439
#line 414
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 418
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 normView = normalize(vec3( _Projector[0][2], _Projector[1][2], _Projector[2][2]));
    highp vec4 vertexPos = (_Object2World * v.vertex);
    o.worldPos = vertexPos;
    #line 422
    highp vec3 worldOrigin = _PlanetOrigin;
    highp vec3 L = (worldOrigin - vec3( vertexPos));
    o.originDist = length(L);
    highp float tc = dot( L, vec3( (-_SunDir)));
    #line 426
    o.dotcoeff = tc;
    highp float d = sqrt((dot( L, L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( L, L) - d2));
    #line 430
    highp float sphereRadius = _Radius;
    mediump float sphereCheck = (step( d, sphereRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((sphereRadius * sphereRadius) - d2));
    highp float sphereDist = mix( 0.0, (tc - tlc), sphereCheck);
    #line 434
    o.worldPos = (vertexPos + (_SunDir * sphereDist));
    o.mainPos = (-(_MainRotation * o.worldPos));
    o.detailPos = (_DetailRotation * o.mainPos);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.posProj);
    xlv_TEXCOORD1 = float(xl_retval.dotcoeff);
    xlv_TEXCOORD2 = float(xl_retval.originDist);
    xlv_TEXCOORD3 = vec4(xl_retval.worldPos);
    xlv_TEXCOORD4 = vec4(xl_retval.mainPos);
    xlv_TEXCOORD5 = vec4(xl_retval.detailPos);
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
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    highp float originDist;
    highp vec4 worldPos;
    highp vec4 mainPos;
    highp vec4 detailPos;
};
#line 397
struct appdata_t {
    highp vec4 vertex;
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
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 386
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 390
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
#line 394
uniform highp float _PlanetRadius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 414
#line 439
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
    highp vec2 uv = ((GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0)) * 4.0) * detailScale);
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
#line 439
lowp vec4 frag( in v2f IN ) {
    mediump float shadowCheck = ((step( 0.0, IN.posProj.w) * step( 0.0, IN.dotcoeff)) * step( IN.originDist, _Radius));
    shadowCheck *= step( _PlanetRadius, (IN.originDist + 5.0));
    #line 443
    mediump vec4 main = GetSphereMap( _MainTex, vec3( IN.mainPos));
    mediump vec4 detail = GetShereDetailMap( _DetailTex, vec3( IN.detailPos), _DetailScale);
    highp float viewDist = distance( IN.worldPos, vec4( _WorldSpaceCameraPos, 0.0));
    mediump float detailLevel = xll_saturate_f(((2.0 * _DetailDist) * viewDist));
    #line 447
    lowp vec4 color = (main.xyzw * mix( detail.xyzw, vec4( 1.0), vec4( detailLevel)));
    color.w = (1.2 * (1.2 - color.w));
    color = xll_saturate_vf4(color);
    return vec4( mix( 1.0, color.w, shadowCheck));
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.dotcoeff = float(xlv_TEXCOORD1);
    xlt_IN.originDist = float(xlv_TEXCOORD2);
    xlt_IN.worldPos = vec4(xlv_TEXCOORD3);
    xlt_IN.mainPos = vec4(xlv_TEXCOORD4);
    xlt_IN.detailPos = vec4(xlv_TEXCOORD5);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 126 to 126, TEX: 6 to 6
//   d3d11 - ALU: 106 to 106, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_WorldSpaceCameraPos]
Float 1 [_DetailScale]
Float 2 [_DetailDist]
Float 3 [_Radius]
Float 4 [_PlanetRadius]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_DetailTex] 2D
"ps_3_0
; 126 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
def c5, 1.00000000, 0.00000000, 5.00000000, -0.21211439
def c6, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c7, 3.14159298, 0.31830987, -0.01348047, 0.05747731
def c8, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c9, 1.57079601, 0.15915494, 0.50000000, 1.27323949
def c10, 1.20019531, -1.00000000, 0, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v5, v5
rsq r0.x, r0.x
mul r2.xyz, r0.x, v5
abs r0.xyz, r2
dsx r3.zw, r2.xyxz
add r0.w, r0.z, -r0.x
dsy r2.xz, r2
mul r2.xz, r2, r2
add r1.xyz, r0.zxyw, -r0
cmp r0.w, r0, c5.x, c5.y
mad r1.xyz, r0.w, r1, r0
add r0.w, r1.x, -r0.y
add r1.xyz, r1, -r0.yxzw
cmp r0.w, r0, c5.x, c5.y
mad r0.xyz, r0.w, r1, r0.yxzw
abs_pp r0.x, r0
rcp_pp r0.x, r0.x
mul_pp r0.xy, r0.zyzw, r0.x
mul_pp r0.xy, r0, c9.z
abs r0.z, r2.y
mul r1.xy, r0, c1.x
add r0.x, -r0.z, c5
mad r0.y, r0.z, c6.x, c6
mad r0.y, r0, r0.z, c5.w
mad r0.y, r0, r0.z, c6.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.y, r0, r0.x
cmp r0.z, r2.y, c5.y, c5.x
mul r0.x, r0.z, r0.y
mad r0.x, -r0, c6.w, r0.y
dp3 r0.w, v4, v4
rsq r0.y, r0.w
mad r0.w, r0.z, c7.x, r0.x
mul r0.xyz, r0.y, v4
mul r0.w, r0, c1.x
mul r0.w, r0, c9
abs r2.w, r0.x
abs r3.x, r0.z
max r1.z, r2.w, r3.x
min r1.w, r2, r3.x
rcp r1.z, r1.z
mul r3.y, r1.w, r1.z
mul r3.zw, r3, r3
add r1.z, r3, r3.w
rsq r1.z, r1.z
rcp r1.z, r1.z
dsx r1.w, r0
dsy r2.y, r0.w
add r0.w, r2.x, r2.z
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r2.x, r0.w, c9.y
mul r1.z, r1, c9.y
texldd r0.w, r1, s1, r1.zwzw, r2
mul r2.x, r3.y, r3.y
add r1.xyz, -v3, c0
dp3 r1.x, r1, r1
mad r2.y, r2.x, c7.z, c7.w
mad r2.y, r2, r2.x, c8.x
mad r1.y, r2, r2.x, c8
mad r1.y, r1, r2.x, c8.z
mad r1.y, r1, r2.x, c8.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.x, r1, c2
abs r1.z, r0.y
add_pp r1.w, -r0, c5.x
mul_sat r1.x, r1, c6.w
mad_pp r2.x, r1, r1.w, r0.w
mul r1.y, r1, r3
add r1.x, r2.w, -r3
dsy r2.zw, r0.xyxz
add r0.w, -r1.y, c9.x
cmp r0.w, -r1.x, r1.y, r0
add r1.x, -r1.z, c5
mad r1.y, r1.z, c6.x, c6
mad r1.y, r1, r1.z, c5.w
mad r1.y, r1, r1.z, c6.z
cmp r1.z, r0.y, c5.y, c5.x
add r0.y, -r0.w, c7.x
cmp r0.y, r0.z, r0.w, r0
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.y, r1, r1.x
mul r1.x, r1.z, r1.y
mad r1.x, -r1, c6.w, r1.y
mad r0.w, r1.z, c7.x, r1.x
cmp r0.y, r0.x, r0, -r0
mul r0.w, r0, c7.y
dsx r1.zw, r0.xyxz
mad r1.x, r0.y, c9.y, c9.z
mul r1.zw, r1, r1
add r0.z, r1, r1.w
rsq r0.z, r0.z
mul r2.zw, r2, r2
add r0.x, r2.z, r2.w
dsx r0.y, r0.w
mov r1.y, r0.w
rsq r0.x, r0.x
rcp r1.z, r0.z
rcp r0.z, r0.x
mul r0.x, r1.z, c9.y
mul r0.z, r0, c9.y
dsy r0.w, r0
texldd r0.w, r1, s0, r0, r0.zwzw
mad_pp r0.x, -r0.w, r2, c10
mul_pp_sat r0.x, r0, c10
cmp r0.y, v1.x, c5.x, c5
cmp r0.z, v0.w, c5.x, c5.y
mul r0.w, r0.z, r0.y
add r0.y, v2.x, -c4.x
add r0.z, -v2.x, c3.x
add r0.y, r0, c5.z
cmp r0.z, r0, c5.x, c5.y
add_pp r0.x, r0, c10.y
cmp r0.y, r0, c5.x, c5
mul r0.z, r0.w, r0
mul_pp r0.y, r0.z, r0
mad_pp oC0, r0.y, r0.x, c5.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 304 // 216 used size, 12 vars
Float 176 [_DetailScale]
Float 180 [_DetailDist]
Float 208 [_Radius]
Float 212 [_PlanetRadius]
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
// 111 instructions, 4 temp regs, 0 temp arrays:
// ALU 96 float, 0 int, 10 uint
// TEX 0 (0 load, 0 comp, 0 bias, 2 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmiepdicenidjggfcpifglpkkbmjjlcpaabaaaaaabmapaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeanaaaaeaaaaaaahjadaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaa
abaaaaaagcbaaaadbcbabaaaacaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafecaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaapgapbaaaaaaaaaaabgbjbaaaafaaaaaadgaaaaaghcaabaaaacaaaaaa
jgahbaiambaaaaaaabaaaaaaaaaaaaaihcaabaaaadaaaaaahgaobaiaibaaaaaa
abaaaaaaegacbaaaacaaaaaabnaaaaajicaabaaaaaaaaaaadkaabaiaibaaaaaa
abaaaaaabkaabaiaibaaaaaaabaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaackaabaaaadaaaaaa
dkaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
adaaaaaajgafbaiaibaaaaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaabgahbaaaacaaaaaaaaaaaaajbcaabaaaacaaaaaabkaabaiambaaaaaa
abaaaaaadkaabaiaibaaaaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaiaibaaaaaaabaaaaaabnaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaiaibaaaaaaabaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaggalbaiaibaaaaaaabaaaaaadiaaaaak
gcaabaaaaaaaaaaakgajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaaoaaaaahdcaabaaaaaaaaaaajgafbaaaaaaaaaaaagaabaaaaaaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaia
ibaaaaaaabaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaakeanmjdpaaaaaaaiicaabaaa
aaaaaaaaakaabaiambaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeadbaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaalaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaidpjkcdpalaaaaafccaabaaaacaaaaaackaabaaaaaaaaaaaamaaaaaf
ccaabaaaadaaaaaackaabaaaaaaaaaaaalaaaaafmcaabaaaaaaaaaaafganbaaa
abaaaaaaamaaaaafdcaabaaaabaaaaaangafbaaaabaaaaaaapaaaaahbcaabaaa
abaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaabaaaaaaabeaaaaa
idpjccdoapaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
adaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaapcaaaaiccaabaaa
aaaaaaaafgafbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agbgbaaaaeaaaaaadeaaaaajbcaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaaddaaaaajccaabaaaabaaaaaa
ckaabaiaibaaaaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
dbaaaaajicaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaabkaabaiaibaaaaaa
aaaaaaaaabaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadbaaaaaigcaabaaaabaaaaaakgalbaaaaaaaaaaakgalbaiaebaaaaaa
aaaaaaaaabaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaanlapejma
aaaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaddaaaaah
ccaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadeaaaaahicaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaabnaaaaaiicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabaaaaahccaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaabaaaaaadhaaaaakbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaak
icaabaaaabaaaaaadkaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaiaibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiambaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeaabaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
idpjkcdoalaaaaafccaabaaaacaaaaaabkaabaaaabaaaaaaamaaaaafccaabaaa
adaaaaaabkaabaaaabaaaaaaalaaaaafmcaabaaaabaaaaaafgajbaaaaaaaaaaa
amaaaaafgcaabaaaaaaaaaaafgagbaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaa
jgafbaaaaaaaaaaajgafbaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaadaaaaaabkaabaaaaaaaaaaaabeaaaaaidpjccdo
apaaaaahccaabaaaaaaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaa
aaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaa
dcaaaaakbcaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaaaaaaaaa
abeaaaaajkjjjjdpdicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
jkjjjjdpaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaialp
bnaaaaahccaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaaaaaaaabnaaaaah
ecaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaakgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaabnaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaabkbabaaaacaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaa
bkbabaaaacaaaaaaabeaaaaaaaaakaeabnaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaanaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab"
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

#LINE 97

      }
   }  
}