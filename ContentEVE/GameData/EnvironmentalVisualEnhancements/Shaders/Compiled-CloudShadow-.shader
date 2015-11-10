// Compiled shader for all platforms, uncompressed size: 107.1KB

Shader "EVE/CloudShadow" {
Properties {
 _Color ("Color Tint", Color) = (1,1,1,1)
 _MainTex ("Main (RGB)", 2D) = "white" {}
 _DetailTex ("Detail (RGB)", 2D) = "white" {}
 _DetailScale ("Detail Scale", Float) = 100
 _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
 _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
 _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
 _Radius ("Radius", Float) = 1
 _PlanetRadius ("Planet Radius", Float) = 1
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 46 math
 //        d3d9 : 51 avg math (50..52)
 //        gles : 157 avg math (155..159), 2 texture, 6 branch
 //       gles3 : 157 avg math (155..159), 2 texture, 6 branch
 //   glesdesktop : 157 avg math (155..159), 2 texture, 6 branch
 //       metal : 42 math
 //      opengl : 157 avg math (155..159), 2 texture, 6 branch
 // Stats for Fragment shader:
 //       d3d11 : 103 avg math (101..105)
 //        d3d9 : 122 avg math (120..124), 6 texture
 //       metal : 157 avg math (155..159), 2 texture, 6 branch
 Pass {
  ZWrite Off
  Blend Zero SrcColor
Program "vp" {
SubProgram "opengl " {
// Stats: 155 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _MainRotation;
uniform mat4 _DetailRotation;
uniform vec4 _SunDir;
uniform float _Radius;
uniform mat4 _Projector;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = -(gl_Vertex.xyz);
  float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1, tmpvar_1));
  float tmpvar_3;
  vec4 cse_4;
  cse_4 = -(_SunDir);
  tmpvar_3 = dot (tmpvar_1, cse_4.xyz);
  float tmpvar_5;
  tmpvar_5 = pow (sqrt((
    dot (tmpvar_1, tmpvar_1)
   - 
    (tmpvar_3 * tmpvar_3)
  )), 2.0);
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_1, tmpvar_1) - tmpvar_5));
  float tmpvar_7;
  tmpvar_7 = sqrt(((_Radius * _Radius) - tmpvar_5));
  vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * (gl_Vertex + 
    (cse_4 * mix (mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 - tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 + tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), float((_Radius >= tmpvar_2))))
  )));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_2)) * float((0.0 >= tmpvar_3)));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform float _DetailScale;
uniform float _DetailDist;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  float tmpvar_2;
  tmpvar_2 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD4.xyz);
  vec2 uv_4;
  float tmpvar_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float tmpvar_6;
    tmpvar_6 = (tmpvar_3.x / tmpvar_3.z);
    tmpvar_5 = (tmpvar_6 * inversesqrt((
      (tmpvar_6 * tmpvar_6)
     + 1.0)));
    tmpvar_5 = (sign(tmpvar_5) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_5)))
     * 
      (1.5708 + (abs(tmpvar_5) * (-0.214602 + (
        abs(tmpvar_5)
       * 
        (0.0865667 + (abs(tmpvar_5) * -0.0310296))
      ))))
    )));
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        tmpvar_5 += 3.14159;
      } else {
        tmpvar_5 = (tmpvar_5 - 3.14159);
      };
    };
  } else {
    tmpvar_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * tmpvar_5));
  uv_4.y = (0.31831 * (1.5708 - (
    sign(tmpvar_3.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_3.y)
    )) * (1.5708 + (
      abs(tmpvar_3.y)
     * 
      (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (
        abs(tmpvar_3.y)
       * -0.0310296))))
    ))))
  )));
  vec2 tmpvar_7;
  tmpvar_7 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_8;
  tmpvar_8 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_9;
  tmpvar_9.x = (0.159155 * sqrt(dot (tmpvar_7, tmpvar_7)));
  tmpvar_9.y = dFdx(uv_4.y);
  tmpvar_9.z = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_9.w = dFdy(uv_4.y);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DGradARB (_MainTex, uv_4, tmpvar_9.xy, tmpvar_9.zw);
  vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5.xyz);
  vec2 uv_12;
  float tmpvar_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    float tmpvar_14;
    tmpvar_14 = (tmpvar_11.x / tmpvar_11.z);
    tmpvar_13 = (tmpvar_14 * inversesqrt((
      (tmpvar_14 * tmpvar_14)
     + 1.0)));
    tmpvar_13 = (sign(tmpvar_13) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_13)))
     * 
      (1.5708 + (abs(tmpvar_13) * (-0.214602 + (
        abs(tmpvar_13)
       * 
        (0.0865667 + (abs(tmpvar_13) * -0.0310296))
      ))))
    )));
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        tmpvar_13 += 3.14159;
      } else {
        tmpvar_13 = (tmpvar_13 - 3.14159);
      };
    };
  } else {
    tmpvar_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * tmpvar_13));
  uv_12.y = (0.31831 * (1.5708 - (
    sign(tmpvar_11.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_11.y)
    )) * (1.5708 + (
      abs(tmpvar_11.y)
     * 
      (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (
        abs(tmpvar_11.y)
       * -0.0310296))))
    ))))
  )));
  vec2 tmpvar_15;
  tmpvar_15 = ((uv_12 * 4.0) * _DetailScale);
  vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_11.xz);
  vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_11.xz);
  vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(tmpvar_15.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(tmpvar_15.y);
  vec3 tmpvar_19;
  tmpvar_19 = abs(tmpvar_11);
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((
    mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20)
   >= tmpvar_19.y))));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_23;
  tmpvar_23 = (xlv_TEXCOORD3 - tmpvar_22);
  vec4 tmpvar_24;
  tmpvar_24 = ((_Color * tmpvar_10) * mix (texture2DGradARB (_DetailTex, (
    ((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x))
   * _DetailScale), tmpvar_18.xy, tmpvar_18.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (
    ((2.0 * _DetailDist) * sqrt(dot (tmpvar_23, tmpvar_23)))
  , 0.0, 1.0))));
  color_1.w = tmpvar_24.w;
  color_1.xyz = clamp ((tmpvar_24.xyz - tmpvar_24.w), 0.0, 1.0);
  color_1.xyz = vec3(mix (1.0, color_1.x, tmpvar_24.w));
  gl_FragData[0] = vec4(mix (1.0, color_1.x, tmpvar_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 50 math
Keywords { "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_MainRotation]
Matrix 12 [_DetailRotation]
Matrix 16 [_Projector]
Vector 20 [_SunDir]
Float 21 [_Radius]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 0.00000000, 0, 0, 0
dcl_position0 v0
dp3 r2.x, -v0, -c20
dp3 r0.x, -v0, -v0
mad r0.y, -r2.x, r2.x, r0.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.w, -r0.y, r0.y, r0.x
mul r0.z, r0.y, r0.y
mad r0.y, c21.x, c21.x, -r0.z
rsq r0.z, r0.w
rsq r0.x, r0.x
rcp r2.y, r0.x
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.z, r0.z
add r0.w, r0.y, -r0.z
add r0.z, r2.x, r0.y
add r1.x, r2, -r0.y
add r0.z, r0, -r0.w
sge r0.y, r2.x, c22.x
mad r0.z, r0.y, r0, r0.w
add r1.x, -r0.w, r1
mad r0.y, r0, r1.x, r0.w
add r0.x, r0.z, -r0.y
sge r2.z, c21.x, r2.y
mad r0.x, r2.z, r0, r0.y
mad r1, r0.x, -c20, v0
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
sge r1.x, c22, r2
mov o5, -r0
dp4 o6.w, -r0, c15
dp4 o6.z, -r0, c14
dp4 o6.y, -r0, c13
dp4 o6.x, -r0, c12
mul o2.x, r2.z, r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c19
dp4 o1.z, v0, c18
dp4 o1.y, v0, c17
dp4 o1.x, v0, c16
mov o3.x, r2.y
dp4 o4.w, v0, c7
dp4 o4.z, v0, c6
dp4 o4.y, v0, c5
dp4 o4.x, v0, c4
"
}
SubProgram "d3d11 " {
// Stats: 46 math
Keywords { "WORLD_SPACE_OFF" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 352
Matrix 48 [_MainRotation]
Matrix 112 [_DetailRotation]
Matrix 288 [_Projector]
Vector 240 [_SunDir]
Float 256 [_Radius]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkpcnbkpmdhobmdagckeagibjckdmjkilabaaaaaagaaiaaaaadaaaaaa
cmaaaaaahmaaaaaaemabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcamahaaaaeaaaabaamdabaaaafjaaaaae
egiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadbccabaaaacaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabcaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabeaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaa
aaaaaaaabfaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaajbcaabaaa
aaaaaaaaegbcbaiaebaaaaaaaaaaaaaaegbcbaiaebaaaaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaiecaabaaaaaaaaaaaakiacaaa
aaaaaaaabaaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaacaaaaaabkaabaaa
aaaaaaaaabaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaakecaabaaaaaaaaaaaegbcbaiaebaaaaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaaapaaaaaabnaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbccabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaa
akiacaaaaaaaaaaabaaaaaaaakiacaaaaaaaaaaabaaaaaaaakaabaiaebaaaaaa
abaaaaaaelaaaaafjcaabaaaaaaaaaaaagambaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalpcaabaaa
aaaaaaaaegiocaiaebaaaaaaaaaaaaaaapaaaaaaagaabaaaaaaaaaaaegbobaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaa
aeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaag
pccabaaaaeaaaaaaegaobaiaebaaaaaaaaaaaaaadiaaaaajpcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaalpcaabaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaalpccabaaaafaaaaaaegiocaaa
aaaaaaaaakaaaaaapgapbaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
"
}
SubProgram "gles " {
// Stats: 155 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = -(_glesVertex.xyz);
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1, tmpvar_1));
  highp float tmpvar_3;
  highp vec4 cse_4;
  cse_4 = -(_SunDir);
  tmpvar_3 = dot (tmpvar_1, cse_4.xyz);
  highp float tmpvar_5;
  tmpvar_5 = pow (sqrt((
    dot (tmpvar_1, tmpvar_1)
   - 
    (tmpvar_3 * tmpvar_3)
  )), 2.0);
  highp float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_1, tmpvar_1) - tmpvar_5));
  highp float tmpvar_7;
  tmpvar_7 = sqrt(((_Radius * _Radius) - tmpvar_5));
  highp vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * (_glesVertex + 
    (cse_4 * mix (mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 - tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 + tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), float((_Radius >= tmpvar_2))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_2)) * float((0.0 >= tmpvar_3)));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_6;
  highp float tmpvar_7;
  if ((abs(tmpvar_5.z) > (1e-08 * abs(tmpvar_5.x)))) {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_5.x / tmpvar_5.z);
    tmpvar_7 = (tmpvar_8 * inversesqrt((
      (tmpvar_8 * tmpvar_8)
     + 1.0)));
    tmpvar_7 = (sign(tmpvar_7) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_7)))
     * 
      (1.5708 + (abs(tmpvar_7) * (-0.214602 + (
        abs(tmpvar_7)
       * 
        (0.0865667 + (abs(tmpvar_7) * -0.0310296))
      ))))
    )));
    if ((tmpvar_5.z < 0.0)) {
      if ((tmpvar_5.x >= 0.0)) {
        tmpvar_7 += 3.14159;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.14159);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_5.x) * 1.5708);
  };
  uv_6.x = (0.5 + (0.159155 * tmpvar_7));
  uv_6.y = (0.31831 * (1.5708 - (
    sign(tmpvar_5.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_5.y)
    )) * (1.5708 + (
      abs(tmpvar_5.y)
     * 
      (-0.214602 + (abs(tmpvar_5.y) * (0.0865667 + (
        abs(tmpvar_5.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_5.xz);
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_5.xz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_6.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_6.y);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DGradEXT (_MainTex, uv_6, tmpvar_11.xy, tmpvar_11.zw);
  mediump vec4 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec4 tmpvar_14;
  mediump vec3 detailCoords_15;
  mediump float nylerp_16;
  mediump float zxlerp_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_19;
  highp float tmpvar_20;
  if ((abs(tmpvar_18.z) > (1e-08 * abs(tmpvar_18.x)))) {
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_18.x / tmpvar_18.z);
    tmpvar_20 = (tmpvar_21 * inversesqrt((
      (tmpvar_21 * tmpvar_21)
     + 1.0)));
    tmpvar_20 = (sign(tmpvar_20) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_20)))
     * 
      (1.5708 + (abs(tmpvar_20) * (-0.214602 + (
        abs(tmpvar_20)
       * 
        (0.0865667 + (abs(tmpvar_20) * -0.0310296))
      ))))
    )));
    if ((tmpvar_18.z < 0.0)) {
      if ((tmpvar_18.x >= 0.0)) {
        tmpvar_20 += 3.14159;
      } else {
        tmpvar_20 = (tmpvar_20 - 3.14159);
      };
    };
  } else {
    tmpvar_20 = (sign(tmpvar_18.x) * 1.5708);
  };
  uv_19.x = (0.5 + (0.159155 * tmpvar_20));
  uv_19.y = (0.31831 * (1.5708 - (
    sign(tmpvar_18.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_18.y)
    )) * (1.5708 + (
      abs(tmpvar_18.y)
     * 
      (-0.214602 + (abs(tmpvar_18.y) * (0.0865667 + (
        abs(tmpvar_18.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((uv_19 * 4.0) * _DetailScale);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(tmpvar_18.xz);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(tmpvar_18.xz);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22.y);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22.y);
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(tmpvar_18);
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_17 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_17) >= tmpvar_26.y));
  nylerp_16 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_17));
  detailCoords_15 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_15, vec3(nylerp_16));
  detailCoords_15 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_15.x);
  highp vec2 coord_32;
  coord_32 = (((0.5 * detailCoords_15.zy) / tmpvar_31) * _DetailScale);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DGradEXT (_DetailTex, coord_32, tmpvar_25.xy, tmpvar_25.zw);
  tmpvar_14 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD3 - tmpvar_34);
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_35, tmpvar_35)
  )), 0.0, 1.0);
  tmpvar_36 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = ((_Color * tmpvar_13) * mix (tmpvar_14, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_36)));
  color_2 = tmpvar_38;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_39;
  tmpvar_39 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 155 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = -(_glesVertex.xyz);
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1, tmpvar_1));
  highp float tmpvar_3;
  highp vec4 cse_4;
  cse_4 = -(_SunDir);
  tmpvar_3 = dot (tmpvar_1, cse_4.xyz);
  highp float tmpvar_5;
  tmpvar_5 = pow (sqrt((
    dot (tmpvar_1, tmpvar_1)
   - 
    (tmpvar_3 * tmpvar_3)
  )), 2.0);
  highp float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_1, tmpvar_1) - tmpvar_5));
  highp float tmpvar_7;
  tmpvar_7 = sqrt(((_Radius * _Radius) - tmpvar_5));
  highp vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * (_glesVertex + 
    (cse_4 * mix (mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 - tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 + tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), float((_Radius >= tmpvar_2))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_2)) * float((0.0 >= tmpvar_3)));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_6;
  highp float tmpvar_7;
  if ((abs(tmpvar_5.z) > (1e-08 * abs(tmpvar_5.x)))) {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_5.x / tmpvar_5.z);
    tmpvar_7 = (tmpvar_8 * inversesqrt((
      (tmpvar_8 * tmpvar_8)
     + 1.0)));
    tmpvar_7 = (sign(tmpvar_7) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_7)))
     * 
      (1.5708 + (abs(tmpvar_7) * (-0.214602 + (
        abs(tmpvar_7)
       * 
        (0.0865667 + (abs(tmpvar_7) * -0.0310296))
      ))))
    )));
    if ((tmpvar_5.z < 0.0)) {
      if ((tmpvar_5.x >= 0.0)) {
        tmpvar_7 += 3.14159;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.14159);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_5.x) * 1.5708);
  };
  uv_6.x = (0.5 + (0.159155 * tmpvar_7));
  uv_6.y = (0.31831 * (1.5708 - (
    sign(tmpvar_5.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_5.y)
    )) * (1.5708 + (
      abs(tmpvar_5.y)
     * 
      (-0.214602 + (abs(tmpvar_5.y) * (0.0865667 + (
        abs(tmpvar_5.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_5.xz);
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_5.xz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_6.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_6.y);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DGradEXT (_MainTex, uv_6, tmpvar_11.xy, tmpvar_11.zw);
  mediump vec4 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec4 tmpvar_14;
  mediump vec3 detailCoords_15;
  mediump float nylerp_16;
  mediump float zxlerp_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_19;
  highp float tmpvar_20;
  if ((abs(tmpvar_18.z) > (1e-08 * abs(tmpvar_18.x)))) {
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_18.x / tmpvar_18.z);
    tmpvar_20 = (tmpvar_21 * inversesqrt((
      (tmpvar_21 * tmpvar_21)
     + 1.0)));
    tmpvar_20 = (sign(tmpvar_20) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_20)))
     * 
      (1.5708 + (abs(tmpvar_20) * (-0.214602 + (
        abs(tmpvar_20)
       * 
        (0.0865667 + (abs(tmpvar_20) * -0.0310296))
      ))))
    )));
    if ((tmpvar_18.z < 0.0)) {
      if ((tmpvar_18.x >= 0.0)) {
        tmpvar_20 += 3.14159;
      } else {
        tmpvar_20 = (tmpvar_20 - 3.14159);
      };
    };
  } else {
    tmpvar_20 = (sign(tmpvar_18.x) * 1.5708);
  };
  uv_19.x = (0.5 + (0.159155 * tmpvar_20));
  uv_19.y = (0.31831 * (1.5708 - (
    sign(tmpvar_18.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_18.y)
    )) * (1.5708 + (
      abs(tmpvar_18.y)
     * 
      (-0.214602 + (abs(tmpvar_18.y) * (0.0865667 + (
        abs(tmpvar_18.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((uv_19 * 4.0) * _DetailScale);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(tmpvar_18.xz);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(tmpvar_18.xz);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22.y);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22.y);
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(tmpvar_18);
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_17 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_17) >= tmpvar_26.y));
  nylerp_16 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_17));
  detailCoords_15 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_15, vec3(nylerp_16));
  detailCoords_15 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_15.x);
  highp vec2 coord_32;
  coord_32 = (((0.5 * detailCoords_15.zy) / tmpvar_31) * _DetailScale);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DGradEXT (_DetailTex, coord_32, tmpvar_25.xy, tmpvar_25.zw);
  tmpvar_14 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD3 - tmpvar_34);
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_35, tmpvar_35)
  )), 0.0, 1.0);
  tmpvar_36 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = ((_Color * tmpvar_13) * mix (tmpvar_14, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_36)));
  color_2 = tmpvar_38;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_39;
  tmpvar_39 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 155 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp mat4 _Projector;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = -(_glesVertex.xyz);
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1, tmpvar_1));
  highp float tmpvar_3;
  highp vec4 cse_4;
  cse_4 = -(_SunDir);
  tmpvar_3 = dot (tmpvar_1, cse_4.xyz);
  highp float tmpvar_5;
  tmpvar_5 = pow (sqrt((
    dot (tmpvar_1, tmpvar_1)
   - 
    (tmpvar_3 * tmpvar_3)
  )), 2.0);
  highp float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_1, tmpvar_1) - tmpvar_5));
  highp float tmpvar_7;
  tmpvar_7 = sqrt(((_Radius * _Radius) - tmpvar_5));
  highp vec4 tmpvar_8;
  tmpvar_8 = -((_MainRotation * (_glesVertex + 
    (cse_4 * mix (mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 - tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 + tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), float((_Radius >= tmpvar_2))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_2)) * float((0.0 >= tmpvar_3)));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_Object2World * _glesVertex);
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_6;
  highp float tmpvar_7;
  if ((abs(tmpvar_5.z) > (1e-08 * abs(tmpvar_5.x)))) {
    highp float tmpvar_8;
    tmpvar_8 = (tmpvar_5.x / tmpvar_5.z);
    tmpvar_7 = (tmpvar_8 * inversesqrt((
      (tmpvar_8 * tmpvar_8)
     + 1.0)));
    tmpvar_7 = (sign(tmpvar_7) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_7)))
     * 
      (1.5708 + (abs(tmpvar_7) * (-0.214602 + (
        abs(tmpvar_7)
       * 
        (0.0865667 + (abs(tmpvar_7) * -0.0310296))
      ))))
    )));
    if ((tmpvar_5.z < 0.0)) {
      if ((tmpvar_5.x >= 0.0)) {
        tmpvar_7 += 3.14159;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.14159);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_5.x) * 1.5708);
  };
  uv_6.x = (0.5 + (0.159155 * tmpvar_7));
  uv_6.y = (0.31831 * (1.5708 - (
    sign(tmpvar_5.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_5.y)
    )) * (1.5708 + (
      abs(tmpvar_5.y)
     * 
      (-0.214602 + (abs(tmpvar_5.y) * (0.0865667 + (
        abs(tmpvar_5.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_9;
  tmpvar_9 = dFdx(tmpvar_5.xz);
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdy(tmpvar_5.xz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dFdx(uv_6.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dFdy(uv_6.y);
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureGrad (_MainTex, uv_6, tmpvar_11.xy, tmpvar_11.zw);
  mediump vec4 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec4 tmpvar_14;
  mediump vec3 detailCoords_15;
  mediump float nylerp_16;
  mediump float zxlerp_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_19;
  highp float tmpvar_20;
  if ((abs(tmpvar_18.z) > (1e-08 * abs(tmpvar_18.x)))) {
    highp float tmpvar_21;
    tmpvar_21 = (tmpvar_18.x / tmpvar_18.z);
    tmpvar_20 = (tmpvar_21 * inversesqrt((
      (tmpvar_21 * tmpvar_21)
     + 1.0)));
    tmpvar_20 = (sign(tmpvar_20) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_20)))
     * 
      (1.5708 + (abs(tmpvar_20) * (-0.214602 + (
        abs(tmpvar_20)
       * 
        (0.0865667 + (abs(tmpvar_20) * -0.0310296))
      ))))
    )));
    if ((tmpvar_18.z < 0.0)) {
      if ((tmpvar_18.x >= 0.0)) {
        tmpvar_20 += 3.14159;
      } else {
        tmpvar_20 = (tmpvar_20 - 3.14159);
      };
    };
  } else {
    tmpvar_20 = (sign(tmpvar_18.x) * 1.5708);
  };
  uv_19.x = (0.5 + (0.159155 * tmpvar_20));
  uv_19.y = (0.31831 * (1.5708 - (
    sign(tmpvar_18.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_18.y)
    )) * (1.5708 + (
      abs(tmpvar_18.y)
     * 
      (-0.214602 + (abs(tmpvar_18.y) * (0.0865667 + (
        abs(tmpvar_18.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_22;
  tmpvar_22 = ((uv_19 * 4.0) * _DetailScale);
  highp vec2 tmpvar_23;
  tmpvar_23 = dFdx(tmpvar_18.xz);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdy(tmpvar_18.xz);
  highp vec4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dFdx(tmpvar_22.y);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dFdy(tmpvar_22.y);
  highp vec3 tmpvar_26;
  tmpvar_26 = abs(tmpvar_18);
  highp float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_17 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, zxlerp_17) >= tmpvar_26.y));
  nylerp_16 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, vec3(zxlerp_17));
  detailCoords_15 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, detailCoords_15, vec3(nylerp_16));
  detailCoords_15 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = abs(detailCoords_15.x);
  highp vec2 coord_32;
  coord_32 = (((0.5 * detailCoords_15.zy) / tmpvar_31) * _DetailScale);
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureGrad (_DetailTex, coord_32, tmpvar_25.xy, tmpvar_25.zw);
  tmpvar_14 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_35;
  tmpvar_35 = (xlv_TEXCOORD3 - tmpvar_34);
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_35, tmpvar_35)
  )), 0.0, 1.0);
  tmpvar_36 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38 = ((_Color * tmpvar_13) * mix (tmpvar_14, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_36)));
  color_2 = tmpvar_38;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_39;
  tmpvar_39 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_39;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 42 math
Keywords { "WORLD_SPACE_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_MainRotation]
Matrix 192 [_DetailRotation]
Matrix 288 [_Projector]
Vector 256 [_SunDir]
Float 272 [_Radius]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD1;
  float xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _MainRotation;
  float4x4 _DetailRotation;
  float4 _SunDir;
  float _Radius;
  float4x4 _Projector;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float3 tmpvar_1;
  tmpvar_1 = -(_mtl_i._glesVertex.xyz);
  float tmpvar_2;
  tmpvar_2 = sqrt(dot (tmpvar_1, tmpvar_1));
  float tmpvar_3;
  float4 cse_4;
  cse_4 = -(_mtl_u._SunDir);
  tmpvar_3 = dot (tmpvar_1, cse_4.xyz);
  float tmpvar_5;
  tmpvar_5 = pow (sqrt((
    dot (tmpvar_1, tmpvar_1)
   - 
    (tmpvar_3 * tmpvar_3)
  )), 2.0);
  float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_1, tmpvar_1) - tmpvar_5));
  float tmpvar_7;
  tmpvar_7 = sqrt(((_mtl_u._Radius * _mtl_u._Radius) - tmpvar_5));
  float4 tmpvar_8;
  tmpvar_8 = -((_mtl_u._MainRotation * (_mtl_i._glesVertex + 
    (cse_4 * mix (mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 - tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), mix ((tmpvar_7 - tmpvar_6), (tmpvar_3 + tmpvar_7), float(
      (tmpvar_3 >= 0.0)
    )), float((_mtl_u._Radius >= tmpvar_2))))
  )));
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Projector * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = (float((_mtl_u._Radius >= tmpvar_2)) * float((0.0 >= tmpvar_3)));
  _mtl_o.xlv_TEXCOORD2 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD3 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD4 = tmpvar_8;
  _mtl_o.xlv_TEXCOORD5 = (_mtl_u._DetailRotation * tmpvar_8);
  return _mtl_o;
}

"
}
SubProgram "opengl " {
// Stats: 159 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_ON" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _MainRotation;
uniform mat4 _DetailRotation;
uniform vec4 _SunDir;
uniform float _Radius;
uniform vec3 _PlanetOrigin;
uniform mat4 _Projector;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex);
  vec3 tmpvar_2;
  tmpvar_2 = (_PlanetOrigin - tmpvar_1.xyz);
  float tmpvar_3;
  tmpvar_3 = sqrt(dot (tmpvar_2, tmpvar_2));
  float tmpvar_4;
  vec4 cse_5;
  cse_5 = -(_SunDir);
  tmpvar_4 = dot (tmpvar_2, cse_5.xyz);
  float tmpvar_6;
  tmpvar_6 = pow (sqrt((
    dot (tmpvar_2, tmpvar_2)
   - 
    (tmpvar_4 * tmpvar_4)
  )), 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (tmpvar_2, tmpvar_2) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = sqrt(((_Radius * _Radius) - tmpvar_6));
  vec4 tmpvar_9;
  tmpvar_9 = -((_MainRotation * (tmpvar_1 + 
    (cse_5 * mix (mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 - tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 + tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), float((_Radius >= tmpvar_3))))
  )));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_3)) * float((0.0 >= tmpvar_4)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_9);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform sampler2D _DetailTex;
uniform float _DetailScale;
uniform float _DetailDist;
uniform float _PlanetRadius;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  float tmpvar_2;
  tmpvar_2 = ((float(
    (xlv_TEXCOORD0.w >= 0.0)
  ) * xlv_TEXCOORD1) * float((
    (xlv_TEXCOORD2 + 5.0)
   >= _PlanetRadius)));
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD4.xyz);
  vec2 uv_4;
  float tmpvar_5;
  if ((abs(tmpvar_3.z) > (1e-08 * abs(tmpvar_3.x)))) {
    float tmpvar_6;
    tmpvar_6 = (tmpvar_3.x / tmpvar_3.z);
    tmpvar_5 = (tmpvar_6 * inversesqrt((
      (tmpvar_6 * tmpvar_6)
     + 1.0)));
    tmpvar_5 = (sign(tmpvar_5) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_5)))
     * 
      (1.5708 + (abs(tmpvar_5) * (-0.214602 + (
        abs(tmpvar_5)
       * 
        (0.0865667 + (abs(tmpvar_5) * -0.0310296))
      ))))
    )));
    if ((tmpvar_3.z < 0.0)) {
      if ((tmpvar_3.x >= 0.0)) {
        tmpvar_5 += 3.14159;
      } else {
        tmpvar_5 = (tmpvar_5 - 3.14159);
      };
    };
  } else {
    tmpvar_5 = (sign(tmpvar_3.x) * 1.5708);
  };
  uv_4.x = (0.5 + (0.159155 * tmpvar_5));
  uv_4.y = (0.31831 * (1.5708 - (
    sign(tmpvar_3.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_3.y)
    )) * (1.5708 + (
      abs(tmpvar_3.y)
     * 
      (-0.214602 + (abs(tmpvar_3.y) * (0.0865667 + (
        abs(tmpvar_3.y)
       * -0.0310296))))
    ))))
  )));
  vec2 tmpvar_7;
  tmpvar_7 = dFdx(tmpvar_3.xz);
  vec2 tmpvar_8;
  tmpvar_8 = dFdy(tmpvar_3.xz);
  vec4 tmpvar_9;
  tmpvar_9.x = (0.159155 * sqrt(dot (tmpvar_7, tmpvar_7)));
  tmpvar_9.y = dFdx(uv_4.y);
  tmpvar_9.z = (0.159155 * sqrt(dot (tmpvar_8, tmpvar_8)));
  tmpvar_9.w = dFdy(uv_4.y);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DGradARB (_MainTex, uv_4, tmpvar_9.xy, tmpvar_9.zw);
  vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD5.xyz);
  vec2 uv_12;
  float tmpvar_13;
  if ((abs(tmpvar_11.z) > (1e-08 * abs(tmpvar_11.x)))) {
    float tmpvar_14;
    tmpvar_14 = (tmpvar_11.x / tmpvar_11.z);
    tmpvar_13 = (tmpvar_14 * inversesqrt((
      (tmpvar_14 * tmpvar_14)
     + 1.0)));
    tmpvar_13 = (sign(tmpvar_13) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_13)))
     * 
      (1.5708 + (abs(tmpvar_13) * (-0.214602 + (
        abs(tmpvar_13)
       * 
        (0.0865667 + (abs(tmpvar_13) * -0.0310296))
      ))))
    )));
    if ((tmpvar_11.z < 0.0)) {
      if ((tmpvar_11.x >= 0.0)) {
        tmpvar_13 += 3.14159;
      } else {
        tmpvar_13 = (tmpvar_13 - 3.14159);
      };
    };
  } else {
    tmpvar_13 = (sign(tmpvar_11.x) * 1.5708);
  };
  uv_12.x = (0.5 + (0.159155 * tmpvar_13));
  uv_12.y = (0.31831 * (1.5708 - (
    sign(tmpvar_11.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_11.y)
    )) * (1.5708 + (
      abs(tmpvar_11.y)
     * 
      (-0.214602 + (abs(tmpvar_11.y) * (0.0865667 + (
        abs(tmpvar_11.y)
       * -0.0310296))))
    ))))
  )));
  vec2 tmpvar_15;
  tmpvar_15 = ((uv_12 * 4.0) * _DetailScale);
  vec2 tmpvar_16;
  tmpvar_16 = dFdx(tmpvar_11.xz);
  vec2 tmpvar_17;
  tmpvar_17 = dFdy(tmpvar_11.xz);
  vec4 tmpvar_18;
  tmpvar_18.x = (0.159155 * sqrt(dot (tmpvar_16, tmpvar_16)));
  tmpvar_18.y = dFdx(tmpvar_15.y);
  tmpvar_18.z = (0.159155 * sqrt(dot (tmpvar_17, tmpvar_17)));
  tmpvar_18.w = dFdy(tmpvar_15.y);
  vec3 tmpvar_19;
  tmpvar_19 = abs(tmpvar_11);
  float tmpvar_20;
  tmpvar_20 = float((tmpvar_19.z >= tmpvar_19.x));
  vec3 tmpvar_21;
  tmpvar_21 = mix (tmpvar_19.yxz, mix (tmpvar_19, tmpvar_19.zxy, vec3(tmpvar_20)), vec3(float((
    mix (tmpvar_19.x, tmpvar_19.z, tmpvar_20)
   >= tmpvar_19.y))));
  vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_23;
  tmpvar_23 = (xlv_TEXCOORD3 - tmpvar_22);
  vec4 tmpvar_24;
  tmpvar_24 = ((_Color * tmpvar_10) * mix (texture2DGradARB (_DetailTex, (
    ((0.5 * tmpvar_21.zy) / abs(tmpvar_21.x))
   * _DetailScale), tmpvar_18.xy, tmpvar_18.zw), vec4(1.0, 1.0, 1.0, 1.0), vec4(clamp (
    ((2.0 * _DetailDist) * sqrt(dot (tmpvar_23, tmpvar_23)))
  , 0.0, 1.0))));
  color_1.w = tmpvar_24.w;
  color_1.xyz = clamp ((tmpvar_24.xyz - tmpvar_24.w), 0.0, 1.0);
  color_1.xyz = vec3(mix (1.0, color_1.x, tmpvar_24.w));
  gl_FragData[0] = vec4(mix (1.0, color_1.x, tmpvar_2));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 52 math
Keywords { "WORLD_SPACE_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_MainRotation]
Matrix 12 [_DetailRotation]
Matrix 16 [_Projector]
Vector 20 [_SunDir]
Float 21 [_Radius]
Vector 22 [_PlanetOrigin]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c23, 0.00000000, 0, 0, 0
dcl_position0 v0
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r2.xyz, -r1, c22
dp3 r3.x, r2, -c20
dp3 r0.x, r2, r2
mad r0.y, -r3.x, r3.x, r0.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.w, -r0.y, r0.y, r0.x
mul r0.z, r0.y, r0.y
mad r0.y, c21.x, c21.x, -r0.z
rsq r0.z, r0.w
rsq r0.x, r0.x
rcp r3.y, r0.x
rsq r0.y, r0.y
rcp r0.y, r0.y
rcp r0.z, r0.z
add r0.w, r0.y, -r0.z
add r0.z, r3.x, r0.y
add r1.w, r3.x, -r0.y
add r0.z, r0, -r0.w
sge r0.y, r3.x, c23.x
mad r0.z, r0.y, r0, r0.w
add r1.w, -r0, r1
mad r0.y, r0, r1.w, r0.w
dp4 r1.w, v0, c7
add r0.x, r0.z, -r0.y
sge r3.z, c21.x, r3.y
mad r0.x, r3.z, r0, r0.y
mad r2, r0.x, -c20, r1
dp4 r0.w, r2, c11
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
sge r2.x, c23, r3
mov o5, -r0
dp4 o6.w, -r0, c15
dp4 o6.z, -r0, c14
dp4 o6.y, -r0, c13
dp4 o6.x, -r0, c12
mul o2.x, r3.z, r2
mov o4, r1
mov o3.x, r3.y
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
// Stats: 46 math
Keywords { "WORLD_SPACE_ON" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 352
Matrix 48 [_MainRotation]
Matrix 112 [_DetailRotation]
Matrix 288 [_Projector]
Vector 240 [_SunDir]
Float 256 [_Radius]
Vector 272 [_PlanetOrigin] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedebhkkmnlhmnplhpmplflnfallkmomaheabaaaaaahmaiaaaaadaaaaaa
cmaaaaaahmaaaaaaemabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcciahaaaaeaaaabaamkabaaaafjaaaaae
egiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadbccabaaaacaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabcaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabeaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaa
aaaaaaaabfaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaabaaaaaajbcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaapaaaaaaelaaaaafccaabaaaabaaaaaa
dkaabaaaabaaaaaadgaaaaafcccabaaaacaaaaaabkaabaaaabaaaaaabnaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaabaaaaaaabkaabaaaabaaaaaabnaaaaah
ecaabaaaabaaaaaaabeaaaaaaaaaaaaaakaabaaaabaaaaaaabaaaaakgcaabaaa
abaaaaaafgagbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaa
diaaaaahbccabaaaacaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadgaaaaaf
pccabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakecaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaakecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaamicaabaaaabaaaaaaakiacaaa
aaaaaaaabaaaaaaaakiacaaaaaaaaaaabaaaaaaaakaabaiaebaaaaaaacaaaaaa
elaaaaafmcaabaaaabaaaaaakgaobaaaabaaaaaaaaaaaaahbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaackaabaia
ebaaaaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaabnaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaalpcaabaaaaaaaaaaa
egiocaiaebaaaaaaaaaaaaaaapaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaagpccabaaa
aeaaaaaaegaobaiaebaaaaaaaaaaaaaadiaaaaajpcaabaaaabaaaaaafgafbaia
ebaaaaaaaaaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaalpcaabaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaaagaabaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaalpcaabaaaabaaaaaaegiocaaaaaaaaaaaajaaaaaakgakbaiaebaaaaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaalpccabaaaafaaaaaaegiocaaaaaaaaaaa
akaaaaaapgapbaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 159 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_2;
  tmpvar_2 = (_PlanetOrigin - tmpvar_1.xyz);
  highp float tmpvar_3;
  tmpvar_3 = sqrt(dot (tmpvar_2, tmpvar_2));
  highp float tmpvar_4;
  highp vec4 cse_5;
  cse_5 = -(_SunDir);
  tmpvar_4 = dot (tmpvar_2, cse_5.xyz);
  highp float tmpvar_6;
  tmpvar_6 = pow (sqrt((
    dot (tmpvar_2, tmpvar_2)
   - 
    (tmpvar_4 * tmpvar_4)
  )), 2.0);
  highp float tmpvar_7;
  tmpvar_7 = sqrt((dot (tmpvar_2, tmpvar_2) - tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = sqrt(((_Radius * _Radius) - tmpvar_6));
  highp vec4 tmpvar_9;
  tmpvar_9 = -((_MainRotation * (tmpvar_1 + 
    (cse_5 * mix (mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 - tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 + tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), float((_Radius >= tmpvar_3))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_3)) * float((0.0 >= tmpvar_4)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_9);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _PlanetRadius;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (shadowCheck_3 * float((
    (xlv_TEXCOORD2 + 5.0)
   >= _PlanetRadius)));
  shadowCheck_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_7;
  highp float tmpvar_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_6.x / tmpvar_6.z);
    tmpvar_8 = (tmpvar_9 * inversesqrt((
      (tmpvar_9 * tmpvar_9)
     + 1.0)));
    tmpvar_8 = (sign(tmpvar_8) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_8)))
     * 
      (1.5708 + (abs(tmpvar_8) * (-0.214602 + (
        abs(tmpvar_8)
       * 
        (0.0865667 + (abs(tmpvar_8) * -0.0310296))
      ))))
    )));
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.14159;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.14159);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * tmpvar_8));
  uv_7.y = (0.31831 * (1.5708 - (
    sign(tmpvar_6.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_6.y)
    )) * (1.5708 + (
      abs(tmpvar_6.y)
     * 
      (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (
        abs(tmpvar_6.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdx(tmpvar_6.xz);
  highp vec2 tmpvar_11;
  tmpvar_11 = dFdy(tmpvar_6.xz);
  highp vec4 tmpvar_12;
  tmpvar_12.x = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_12.y = dFdx(uv_7.y);
  tmpvar_12.z = (0.159155 * sqrt(dot (tmpvar_11, tmpvar_11)));
  tmpvar_12.w = dFdy(uv_7.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DGradEXT (_MainTex, uv_7, tmpvar_12.xy, tmpvar_12.zw);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  mediump vec4 tmpvar_15;
  mediump vec3 detailCoords_16;
  mediump float nylerp_17;
  mediump float zxlerp_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_20;
  highp float tmpvar_21;
  if ((abs(tmpvar_19.z) > (1e-08 * abs(tmpvar_19.x)))) {
    highp float tmpvar_22;
    tmpvar_22 = (tmpvar_19.x / tmpvar_19.z);
    tmpvar_21 = (tmpvar_22 * inversesqrt((
      (tmpvar_22 * tmpvar_22)
     + 1.0)));
    tmpvar_21 = (sign(tmpvar_21) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_21)))
     * 
      (1.5708 + (abs(tmpvar_21) * (-0.214602 + (
        abs(tmpvar_21)
       * 
        (0.0865667 + (abs(tmpvar_21) * -0.0310296))
      ))))
    )));
    if ((tmpvar_19.z < 0.0)) {
      if ((tmpvar_19.x >= 0.0)) {
        tmpvar_21 += 3.14159;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.14159);
      };
    };
  } else {
    tmpvar_21 = (sign(tmpvar_19.x) * 1.5708);
  };
  uv_20.x = (0.5 + (0.159155 * tmpvar_21));
  uv_20.y = (0.31831 * (1.5708 - (
    sign(tmpvar_19.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_19.y)
    )) * (1.5708 + (
      abs(tmpvar_19.y)
     * 
      (-0.214602 + (abs(tmpvar_19.y) * (0.0865667 + (
        abs(tmpvar_19.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_23;
  tmpvar_23 = ((uv_20 * 4.0) * _DetailScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdx(tmpvar_19.xz);
  highp vec2 tmpvar_25;
  tmpvar_25 = dFdy(tmpvar_19.xz);
  highp vec4 tmpvar_26;
  tmpvar_26.x = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_26.y = dFdx(tmpvar_23.y);
  tmpvar_26.z = (0.159155 * sqrt(dot (tmpvar_25, tmpvar_25)));
  tmpvar_26.w = dFdy(tmpvar_23.y);
  highp vec3 tmpvar_27;
  tmpvar_27 = abs(tmpvar_19);
  highp float tmpvar_28;
  tmpvar_28 = float((tmpvar_27.z >= tmpvar_27.x));
  zxlerp_18 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = float((mix (tmpvar_27.x, tmpvar_27.z, zxlerp_18) >= tmpvar_27.y));
  nylerp_17 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_27, tmpvar_27.zxy, vec3(zxlerp_18));
  detailCoords_16 = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (tmpvar_27.yxz, detailCoords_16, vec3(nylerp_17));
  detailCoords_16 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = abs(detailCoords_16.x);
  highp vec2 coord_33;
  coord_33 = (((0.5 * detailCoords_16.zy) / tmpvar_32) * _DetailScale);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DGradEXT (_DetailTex, coord_33, tmpvar_26.xy, tmpvar_26.zw);
  tmpvar_15 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_36;
  tmpvar_36 = (xlv_TEXCOORD3 - tmpvar_35);
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_36, tmpvar_36)
  )), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = ((_Color * tmpvar_14) * mix (tmpvar_15, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_37)));
  color_2 = tmpvar_39;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_40;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 159 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_2;
  tmpvar_2 = (_PlanetOrigin - tmpvar_1.xyz);
  highp float tmpvar_3;
  tmpvar_3 = sqrt(dot (tmpvar_2, tmpvar_2));
  highp float tmpvar_4;
  highp vec4 cse_5;
  cse_5 = -(_SunDir);
  tmpvar_4 = dot (tmpvar_2, cse_5.xyz);
  highp float tmpvar_6;
  tmpvar_6 = pow (sqrt((
    dot (tmpvar_2, tmpvar_2)
   - 
    (tmpvar_4 * tmpvar_4)
  )), 2.0);
  highp float tmpvar_7;
  tmpvar_7 = sqrt((dot (tmpvar_2, tmpvar_2) - tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = sqrt(((_Radius * _Radius) - tmpvar_6));
  highp vec4 tmpvar_9;
  tmpvar_9 = -((_MainRotation * (tmpvar_1 + 
    (cse_5 * mix (mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 - tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 + tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), float((_Radius >= tmpvar_3))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_3)) * float((0.0 >= tmpvar_4)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_9);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _PlanetRadius;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (shadowCheck_3 * float((
    (xlv_TEXCOORD2 + 5.0)
   >= _PlanetRadius)));
  shadowCheck_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_7;
  highp float tmpvar_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_6.x / tmpvar_6.z);
    tmpvar_8 = (tmpvar_9 * inversesqrt((
      (tmpvar_9 * tmpvar_9)
     + 1.0)));
    tmpvar_8 = (sign(tmpvar_8) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_8)))
     * 
      (1.5708 + (abs(tmpvar_8) * (-0.214602 + (
        abs(tmpvar_8)
       * 
        (0.0865667 + (abs(tmpvar_8) * -0.0310296))
      ))))
    )));
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.14159;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.14159);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * tmpvar_8));
  uv_7.y = (0.31831 * (1.5708 - (
    sign(tmpvar_6.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_6.y)
    )) * (1.5708 + (
      abs(tmpvar_6.y)
     * 
      (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (
        abs(tmpvar_6.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdx(tmpvar_6.xz);
  highp vec2 tmpvar_11;
  tmpvar_11 = dFdy(tmpvar_6.xz);
  highp vec4 tmpvar_12;
  tmpvar_12.x = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_12.y = dFdx(uv_7.y);
  tmpvar_12.z = (0.159155 * sqrt(dot (tmpvar_11, tmpvar_11)));
  tmpvar_12.w = dFdy(uv_7.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DGradEXT (_MainTex, uv_7, tmpvar_12.xy, tmpvar_12.zw);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  mediump vec4 tmpvar_15;
  mediump vec3 detailCoords_16;
  mediump float nylerp_17;
  mediump float zxlerp_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_20;
  highp float tmpvar_21;
  if ((abs(tmpvar_19.z) > (1e-08 * abs(tmpvar_19.x)))) {
    highp float tmpvar_22;
    tmpvar_22 = (tmpvar_19.x / tmpvar_19.z);
    tmpvar_21 = (tmpvar_22 * inversesqrt((
      (tmpvar_22 * tmpvar_22)
     + 1.0)));
    tmpvar_21 = (sign(tmpvar_21) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_21)))
     * 
      (1.5708 + (abs(tmpvar_21) * (-0.214602 + (
        abs(tmpvar_21)
       * 
        (0.0865667 + (abs(tmpvar_21) * -0.0310296))
      ))))
    )));
    if ((tmpvar_19.z < 0.0)) {
      if ((tmpvar_19.x >= 0.0)) {
        tmpvar_21 += 3.14159;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.14159);
      };
    };
  } else {
    tmpvar_21 = (sign(tmpvar_19.x) * 1.5708);
  };
  uv_20.x = (0.5 + (0.159155 * tmpvar_21));
  uv_20.y = (0.31831 * (1.5708 - (
    sign(tmpvar_19.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_19.y)
    )) * (1.5708 + (
      abs(tmpvar_19.y)
     * 
      (-0.214602 + (abs(tmpvar_19.y) * (0.0865667 + (
        abs(tmpvar_19.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_23;
  tmpvar_23 = ((uv_20 * 4.0) * _DetailScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdx(tmpvar_19.xz);
  highp vec2 tmpvar_25;
  tmpvar_25 = dFdy(tmpvar_19.xz);
  highp vec4 tmpvar_26;
  tmpvar_26.x = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_26.y = dFdx(tmpvar_23.y);
  tmpvar_26.z = (0.159155 * sqrt(dot (tmpvar_25, tmpvar_25)));
  tmpvar_26.w = dFdy(tmpvar_23.y);
  highp vec3 tmpvar_27;
  tmpvar_27 = abs(tmpvar_19);
  highp float tmpvar_28;
  tmpvar_28 = float((tmpvar_27.z >= tmpvar_27.x));
  zxlerp_18 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = float((mix (tmpvar_27.x, tmpvar_27.z, zxlerp_18) >= tmpvar_27.y));
  nylerp_17 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_27, tmpvar_27.zxy, vec3(zxlerp_18));
  detailCoords_16 = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (tmpvar_27.yxz, detailCoords_16, vec3(nylerp_17));
  detailCoords_16 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = abs(detailCoords_16.x);
  highp vec2 coord_33;
  coord_33 = (((0.5 * detailCoords_16.zy) / tmpvar_32) * _DetailScale);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DGradEXT (_DetailTex, coord_33, tmpvar_26.xy, tmpvar_26.zw);
  tmpvar_15 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_36;
  tmpvar_36 = (xlv_TEXCOORD3 - tmpvar_35);
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_36, tmpvar_36)
  )), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = ((_Color * tmpvar_14) * mix (tmpvar_15, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_37)));
  color_2 = tmpvar_39;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_40;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 159 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_2;
  tmpvar_2 = (_PlanetOrigin - tmpvar_1.xyz);
  highp float tmpvar_3;
  tmpvar_3 = sqrt(dot (tmpvar_2, tmpvar_2));
  highp float tmpvar_4;
  highp vec4 cse_5;
  cse_5 = -(_SunDir);
  tmpvar_4 = dot (tmpvar_2, cse_5.xyz);
  highp float tmpvar_6;
  tmpvar_6 = pow (sqrt((
    dot (tmpvar_2, tmpvar_2)
   - 
    (tmpvar_4 * tmpvar_4)
  )), 2.0);
  highp float tmpvar_7;
  tmpvar_7 = sqrt((dot (tmpvar_2, tmpvar_2) - tmpvar_6));
  highp float tmpvar_8;
  tmpvar_8 = sqrt(((_Radius * _Radius) - tmpvar_6));
  highp vec4 tmpvar_9;
  tmpvar_9 = -((_MainRotation * (tmpvar_1 + 
    (cse_5 * mix (mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 - tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 + tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), float((_Radius >= tmpvar_3))))
  )));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = (float((_Radius >= tmpvar_3)) * float((0.0 >= tmpvar_4)));
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = (_DetailRotation * tmpvar_9);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _DetailTex;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp float _PlanetRadius;
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
in highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * xlv_TEXCOORD1);
  shadowCheck_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (shadowCheck_3 * float((
    (xlv_TEXCOORD2 + 5.0)
   >= _PlanetRadius)));
  shadowCheck_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_7;
  highp float tmpvar_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    highp float tmpvar_9;
    tmpvar_9 = (tmpvar_6.x / tmpvar_6.z);
    tmpvar_8 = (tmpvar_9 * inversesqrt((
      (tmpvar_9 * tmpvar_9)
     + 1.0)));
    tmpvar_8 = (sign(tmpvar_8) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_8)))
     * 
      (1.5708 + (abs(tmpvar_8) * (-0.214602 + (
        abs(tmpvar_8)
       * 
        (0.0865667 + (abs(tmpvar_8) * -0.0310296))
      ))))
    )));
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.14159;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.14159);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * tmpvar_8));
  uv_7.y = (0.31831 * (1.5708 - (
    sign(tmpvar_6.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_6.y)
    )) * (1.5708 + (
      abs(tmpvar_6.y)
     * 
      (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (
        abs(tmpvar_6.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = dFdx(tmpvar_6.xz);
  highp vec2 tmpvar_11;
  tmpvar_11 = dFdy(tmpvar_6.xz);
  highp vec4 tmpvar_12;
  tmpvar_12.x = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_12.y = dFdx(uv_7.y);
  tmpvar_12.z = (0.159155 * sqrt(dot (tmpvar_11, tmpvar_11)));
  tmpvar_12.w = dFdy(uv_7.y);
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureGrad (_MainTex, uv_7, tmpvar_12.xy, tmpvar_12.zw);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  mediump vec4 tmpvar_15;
  mediump vec3 detailCoords_16;
  mediump float nylerp_17;
  mediump float zxlerp_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(xlv_TEXCOORD5.xyz);
  highp vec2 uv_20;
  highp float tmpvar_21;
  if ((abs(tmpvar_19.z) > (1e-08 * abs(tmpvar_19.x)))) {
    highp float tmpvar_22;
    tmpvar_22 = (tmpvar_19.x / tmpvar_19.z);
    tmpvar_21 = (tmpvar_22 * inversesqrt((
      (tmpvar_22 * tmpvar_22)
     + 1.0)));
    tmpvar_21 = (sign(tmpvar_21) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_21)))
     * 
      (1.5708 + (abs(tmpvar_21) * (-0.214602 + (
        abs(tmpvar_21)
       * 
        (0.0865667 + (abs(tmpvar_21) * -0.0310296))
      ))))
    )));
    if ((tmpvar_19.z < 0.0)) {
      if ((tmpvar_19.x >= 0.0)) {
        tmpvar_21 += 3.14159;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.14159);
      };
    };
  } else {
    tmpvar_21 = (sign(tmpvar_19.x) * 1.5708);
  };
  uv_20.x = (0.5 + (0.159155 * tmpvar_21));
  uv_20.y = (0.31831 * (1.5708 - (
    sign(tmpvar_19.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_19.y)
    )) * (1.5708 + (
      abs(tmpvar_19.y)
     * 
      (-0.214602 + (abs(tmpvar_19.y) * (0.0865667 + (
        abs(tmpvar_19.y)
       * -0.0310296))))
    ))))
  )));
  highp vec2 tmpvar_23;
  tmpvar_23 = ((uv_20 * 4.0) * _DetailScale);
  highp vec2 tmpvar_24;
  tmpvar_24 = dFdx(tmpvar_19.xz);
  highp vec2 tmpvar_25;
  tmpvar_25 = dFdy(tmpvar_19.xz);
  highp vec4 tmpvar_26;
  tmpvar_26.x = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_26.y = dFdx(tmpvar_23.y);
  tmpvar_26.z = (0.159155 * sqrt(dot (tmpvar_25, tmpvar_25)));
  tmpvar_26.w = dFdy(tmpvar_23.y);
  highp vec3 tmpvar_27;
  tmpvar_27 = abs(tmpvar_19);
  highp float tmpvar_28;
  tmpvar_28 = float((tmpvar_27.z >= tmpvar_27.x));
  zxlerp_18 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = float((mix (tmpvar_27.x, tmpvar_27.z, zxlerp_18) >= tmpvar_27.y));
  nylerp_17 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_27, tmpvar_27.zxy, vec3(zxlerp_18));
  detailCoords_16 = tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = mix (tmpvar_27.yxz, detailCoords_16, vec3(nylerp_17));
  detailCoords_16 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = abs(detailCoords_16.x);
  highp vec2 coord_33;
  coord_33 = (((0.5 * detailCoords_16.zy) / tmpvar_32) * _DetailScale);
  lowp vec4 tmpvar_34;
  tmpvar_34 = textureGrad (_DetailTex, coord_33, tmpvar_26.xy, tmpvar_26.zw);
  tmpvar_15 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_36;
  tmpvar_36 = (xlv_TEXCOORD3 - tmpvar_35);
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (((2.0 * _DetailDist) * sqrt(
    dot (tmpvar_36, tmpvar_36)
  )), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = ((_Color * tmpvar_14) * mix (tmpvar_15, vec4(1.0, 1.0, 1.0, 1.0), vec4(tmpvar_37)));
  color_2 = tmpvar_39;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), 0.0, 1.0);
  color_2.xyz = vec3(mix (1.0, color_2.x, color_2.w));
  mediump vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_40;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 42 math
Keywords { "WORLD_SPACE_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 368
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 128 [_MainRotation]
Matrix 192 [_DetailRotation]
Matrix 304 [_Projector]
Vector 256 [_SunDir]
Float 272 [_Radius]
Vector 288 [_PlanetOrigin] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD1;
  float xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float4 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4x4 _MainRotation;
  float4x4 _DetailRotation;
  float4 _SunDir;
  float _Radius;
  float3 _PlanetOrigin;
  float4x4 _Projector;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  tmpvar_1 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_2;
  tmpvar_2 = (_mtl_u._PlanetOrigin - tmpvar_1.xyz);
  float tmpvar_3;
  tmpvar_3 = sqrt(dot (tmpvar_2, tmpvar_2));
  float tmpvar_4;
  float4 cse_5;
  cse_5 = -(_mtl_u._SunDir);
  tmpvar_4 = dot (tmpvar_2, cse_5.xyz);
  float tmpvar_6;
  tmpvar_6 = pow (sqrt((
    dot (tmpvar_2, tmpvar_2)
   - 
    (tmpvar_4 * tmpvar_4)
  )), 2.0);
  float tmpvar_7;
  tmpvar_7 = sqrt((dot (tmpvar_2, tmpvar_2) - tmpvar_6));
  float tmpvar_8;
  tmpvar_8 = sqrt(((_mtl_u._Radius * _mtl_u._Radius) - tmpvar_6));
  float4 tmpvar_9;
  tmpvar_9 = -((_mtl_u._MainRotation * (tmpvar_1 + 
    (cse_5 * mix (mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 - tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), mix ((tmpvar_8 - tmpvar_7), (tmpvar_4 + tmpvar_8), float(
      (tmpvar_4 >= 0.0)
    )), float((_mtl_u._Radius >= tmpvar_3))))
  )));
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Projector * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = (float((_mtl_u._Radius >= tmpvar_3)) * float((0.0 >= tmpvar_4)));
  _mtl_o.xlv_TEXCOORD2 = tmpvar_3;
  _mtl_o.xlv_TEXCOORD3 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD4 = tmpvar_9;
  _mtl_o.xlv_TEXCOORD5 = (_mtl_u._DetailRotation * tmpvar_9);
  return _mtl_o;
}

"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "WORLD_SPACE_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 120 math, 6 textures
Keywords { "WORLD_SPACE_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_Color]
Float 2 [_DetailScale]
Float 3 [_DetailDist]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0.00000000, -0.01872930, 0.07426100
def c5, -0.21211439, 1.57072902, 2.00000000, 3.14159298
def c6, 0.31830987, -0.01348047, 0.05747731, -0.12123910
def c7, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c8, 0.15915494, 0.50000000, 1.27323949, -1.00000000
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord3 v2.xyz
dcl_texcoord4 v3.xyz
dcl_texcoord5 v4.xyz
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul r1.xyz, r0.x, v3
abs r1.w, r1.z
abs r0.w, r1.x
max r0.y, r0.w, r1.w
min r0.x, r0.w, r1.w
add r0.w, r0, -r1
abs r1.w, r1.y
rcp r0.y, r0.y
mul r2.w, r0.x, r0.y
mul r4.x, r2.w, r2.w
mad r3.x, r4, c6.y, c6.z
mad r3.w, r3.x, r4.x, c6
dp3 r0.z, v4, v4
rsq r0.x, r0.z
mul r0.xyz, r0.x, v4
abs r2.xyz, r0
add r4.y, r2.z, -r2.x
mad r3.w, r3, r4.x, c7.x
cmp r1.y, r1, c4, c4.x
add r3.xyz, r2.zxyw, -r2
cmp r4.y, r4, c4.x, c4
mad r3.xyz, r4.y, r3, r2
mad r4.y, r3.w, r4.x, c7
add r4.z, r3.x, -r2.y
mad r4.x, r4.y, r4, c7.z
mul r2.w, r4.x, r2
dsy r4.xy, r1.xzzw
add r3.xyz, r3, -r2.yxzw
cmp r3.w, r4.z, c4.x, c4.y
mad r2.xyz, r3.w, r3, r2.yxzw
add r3.x, -r2.w, c7.w
cmp r0.w, -r0, r2, r3.x
dsx r3.zw, r1.xyxz
add r3.x, -r1.w, c4
mad r2.w, r1, c4.z, c4
mad r2.w, r2, r1, c5.x
rsq r3.x, r3.x
rcp r3.x, r3.x
mad r1.w, r2, r1, c5.y
mul r1.w, r1, r3.x
mul r2.w, r1.y, r1
add r3.x, -r0.w, c5.w
mad r1.w, -r2, c5.z, r1
cmp r2.w, r1.z, r0, r3.x
mad r0.w, r1.y, c5, r1
mul r0.w, r0, c6.x
cmp r1.y, r1.x, r2.w, -r2.w
mad r3.x, r1.y, c8, c8.y
mul r4.xy, r4, r4
add r1.x, r4, r4.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mov r3.y, r0.w
dsy r1.y, r0.w
dsx r1.w, r0
mul r3.zw, r3, r3
add r0.w, r3.z, r3
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r1.z, r0.w, c8.x
abs_pp r0.w, r2.x
mul r1.x, r1, c8
texldd r1.xw, r3, s0, r1.zwzw, r1
abs r1.y, r0
add r2.x, -r1.y, c4
mad r1.z, r1.y, c4, c4.w
mad r1.z, r1, r1.y, c5.x
rsq r2.x, r2.x
rcp_pp r0.w, r0.w
rcp r2.x, r2.x
mad r1.y, r1.z, r1, c5
mul r1.y, r1, r2.x
mul_pp r2.xy, r2.zyzw, r0.w
dsx r2.zw, r0.xyxz
cmp r0.y, r0, c4, c4.x
mul r1.z, r0.y, r1.y
mad r0.w, -r1.z, c5.z, r1.y
mad r0.y, r0, c5.w, r0.w
mul r0.y, r0, c2.x
mul r1.z, r0.y, c8
add r3.xyz, -v2, c0
dp3 r0.y, r3, r3
rsq r1.y, r0.y
dsy r3.xy, r0.xzzw
mul_pp r2.xy, r2, c8.y
mul r2.zw, r2, r2
mul r3.xy, r3, r3
add r0.x, r2.z, r2.w
add r0.z, r3.x, r3.y
rsq r0.x, r0.x
dsy r0.y, r1.z
mul r2.xy, r2, c2.x
dsx r0.w, r1.z
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r1.z, r0.z
mul r0.z, r0.x, c8.x
mul r0.x, r1.z, c8
texldd r0.xw, r2, s1, r0.zwzw, r0
rcp r1.y, r1.y
mul r0.y, r1, c3.x
add_pp r2.xy, -r0.xwzw, c4.x
mul_sat r0.y, r0, c5.z
mad_pp r0.zw, r0.y, r2.xyxy, r0.xyxw
mul_pp r0.xy, r1.xwzw, c1.xwzw
mul_pp r0.xy, r0, r0.zwzw
add_pp_sat r0.x, r0, -r0.y
add_pp r0.z, r0.x, c8.w
cmp r0.x, v0.w, c4, c4.y
mul_pp r0.y, r0, r0.z
mul r0.x, r0, v1
mad_pp oC0, r0.x, r0.y, c4.x
"
}
SubProgram "d3d11 " {
// Stats: 101 math
Keywords { "WORLD_SPACE_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
ConstBuffer "$Globals" 352
Vector 192 [_Color]
Float 224 [_DetailScale]
Float 228 [_DetailDist]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpheojmbbenmajfamegjbhlgeliaokkemabaaaaaajiaoaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaanaaaaeaaaaaaafiadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaa
abaaaaaagcbaaaadbcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaigbbbaaaaeaaaaaadeaaaaajicaabaaaaaaaaaaa
bkaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaaoaaaaakicaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
ddaaaaajbcaabaaaabaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
ccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
ochgdidodcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaebnkjlodcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaajecaabaaaabaaaaaabkaabaiaibaaaaaa
aaaaaaaaakaabaiaibaaaaaaaaaaaaaaabaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadbaaaaaidcaabaaaabaaaaaajgafbaaa
aaaaaaaajgafbaiaebaaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadbaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaadeaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
bnaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
abaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaak
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaidpjccdo
abeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaakeanmjdp
aaaaaaaiecaabaaaaaaaaaaackaabaiambaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeaabaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaacaaaaaa
ckaabaaaaaaaaaaaabeaaaaaidpjkcdoalaaaaafccaabaaaabaaaaaabkaabaaa
acaaaaaaamaaaaafccaabaaaadaaaaaabkaabaaaacaaaaaaalaaaaafmcaabaaa
aaaaaaaaagaebaaaaaaaaaaaamaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaa
aaaaaaaaabeaaaaaidpjccdoapaaaaahbcaabaaaaaaaaaaaogakbaaaaaaaaaaa
ogakbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaa
aaaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaadaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaamaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaa
baaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahpcaabaaaacaaaaaapgapbaaa
abaaaaaabgbjbaaaafaaaaaadgaaaaaghcaabaaaadaaaaaajgahbaiambaaaaaa
acaaaaaaaaaaaaaihcaabaaaaeaaaaaahgaobaiaibaaaaaaacaaaaaaegacbaaa
adaaaaaabnaaaaajicaabaaaabaaaaaadkaabaiaibaaaaaaacaaaaaabkaabaia
ibaaaaaaacaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaadaaaaaackaabaaaaeaaaaaadkaabaaaabaaaaaa
dcaaaaakdcaabaaaabaaaaaapgapbaaaabaaaaaaegaabaaaaeaaaaaajgafbaia
ibaaaaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaabgahbaaa
adaaaaaaaaaaaaajbcaabaaaadaaaaaabkaabaiambaaaaaaacaaaaaadkaabaia
ibaaaaaaacaaaaaadcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
adaaaaaabkaabaiaibaaaaaaacaaaaaabnaaaaaiicaabaaaabaaaaaadkaabaaa
abaaaaaackaabaiaibaaaaaaacaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaggalbaiaibaaaaaaacaaaaaadiaaaaakgcaabaaaabaaaaaa
kgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaaoaaaaah
dcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaaabaaaaaadcaaaaakecaabaaa
abaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakecaabaaaabaaaaaackaabaaaabaaaaaaakaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakecaabaaaabaaaaaackaabaaaabaaaaaaakaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaaiicaabaaaabaaaaaaakaabaia
mbaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeadbaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaa
aoaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaidpjkcdp
alaaaaafccaabaaaadaaaaaackaabaaaabaaaaaaamaaaaafccaabaaaaeaaaaaa
ckaabaaaabaaaaaaalaaaaafmcaabaaaabaaaaaafganbaaaacaaaaaaamaaaaaf
dcaabaaaacaaaaaangafbaaaacaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahbcaabaaaaeaaaaaaakaabaaaacaaaaaaabeaaaaaidpjccdoapaaaaah
ecaabaaaabaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaadaaaaaackaabaaaabaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaaeaaaaaaaaaaaaal
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaaaaaaajhcaabaaaadaaaaaaegbcbaaaadaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaaapcaaaai
bcaabaaaadaaaaaaagaabaaaadaaaaaafgifcaaaaaaaaaaaaoaaaaaadcaaaaaj
pcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadccaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaa
acaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaa
pgapbaaaacaaaaaaaaaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaialpbnaaaaahbcaabaaaabaaaaaadkbabaaa
abaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakbabaaa
acaaaaaadcaaaaampccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab"
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
SubProgram "metal " {
// Stats: 155 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
ConstBuffer "$Globals" 32
Vector 0 [_WorldSpaceCameraPos] 3
VectorHalf 16 [_Color] 4
Float 24 [_DetailScale]
Float 28 [_DetailDist]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD1;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float4 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _Color;
  float _DetailScale;
  float _DetailDist;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _DetailTex [[texture(1)]], sampler _mtlsmp__DetailTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  half shadowCheck_3;
  float tmpvar_4;
  tmpvar_4 = (float((_mtl_i.xlv_TEXCOORD0.w >= 0.0)) * _mtl_i.xlv_TEXCOORD1);
  shadowCheck_3 = half(tmpvar_4);
  float3 tmpvar_5;
  tmpvar_5 = normalize(_mtl_i.xlv_TEXCOORD4.xyz);
  float2 uv_6;
  float tmpvar_7;
  if ((abs(tmpvar_5.z) > (1e-08 * abs(tmpvar_5.x)))) {
    float tmpvar_8;
    tmpvar_8 = (tmpvar_5.x / tmpvar_5.z);
    tmpvar_7 = (tmpvar_8 * rsqrt((
      (tmpvar_8 * tmpvar_8)
     + 1.0)));
    tmpvar_7 = (sign(tmpvar_7) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_7)))
     * 
      (1.5708 + (abs(tmpvar_7) * (-0.214602 + (
        abs(tmpvar_7)
       * 
        (0.0865667 + (abs(tmpvar_7) * -0.0310296))
      ))))
    )));
    if ((tmpvar_5.z < 0.0)) {
      if ((tmpvar_5.x >= 0.0)) {
        tmpvar_7 += 3.14159;
      } else {
        tmpvar_7 = (tmpvar_7 - 3.14159);
      };
    };
  } else {
    tmpvar_7 = (sign(tmpvar_5.x) * 1.5708);
  };
  uv_6.x = (0.5 + (0.159155 * tmpvar_7));
  uv_6.y = (0.31831 * (1.5708 - (
    sign(tmpvar_5.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_5.y)
    )) * (1.5708 + (
      abs(tmpvar_5.y)
     * 
      (-0.214602 + (abs(tmpvar_5.y) * (0.0865667 + (
        abs(tmpvar_5.y)
       * -0.0310296))))
    ))))
  )));
  float2 tmpvar_9;
  tmpvar_9 = dfdx(tmpvar_5.xz);
  float2 tmpvar_10;
  tmpvar_10 = dfdy(tmpvar_5.xz);
  float4 tmpvar_11;
  tmpvar_11.x = (0.159155 * sqrt(dot (tmpvar_9, tmpvar_9)));
  tmpvar_11.y = dfdx(uv_6.y);
  tmpvar_11.z = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_11.w = dfdy(uv_6.y);
  half4 tmpvar_12;
  tmpvar_12 = _MainTex.sample(_mtlsmp__MainTex, (float2)(uv_6), gradient2d((float2)(tmpvar_11.xy), (float2)(tmpvar_11.zw)));
  half4 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  half4 tmpvar_14;
  half3 detailCoords_15;
  half nylerp_16;
  half zxlerp_17;
  float3 tmpvar_18;
  tmpvar_18 = normalize(_mtl_i.xlv_TEXCOORD5.xyz);
  float2 uv_19;
  float tmpvar_20;
  if ((abs(tmpvar_18.z) > (1e-08 * abs(tmpvar_18.x)))) {
    float tmpvar_21;
    tmpvar_21 = (tmpvar_18.x / tmpvar_18.z);
    tmpvar_20 = (tmpvar_21 * rsqrt((
      (tmpvar_21 * tmpvar_21)
     + 1.0)));
    tmpvar_20 = (sign(tmpvar_20) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_20)))
     * 
      (1.5708 + (abs(tmpvar_20) * (-0.214602 + (
        abs(tmpvar_20)
       * 
        (0.0865667 + (abs(tmpvar_20) * -0.0310296))
      ))))
    )));
    if ((tmpvar_18.z < 0.0)) {
      if ((tmpvar_18.x >= 0.0)) {
        tmpvar_20 += 3.14159;
      } else {
        tmpvar_20 = (tmpvar_20 - 3.14159);
      };
    };
  } else {
    tmpvar_20 = (sign(tmpvar_18.x) * 1.5708);
  };
  uv_19.x = (0.5 + (0.159155 * tmpvar_20));
  uv_19.y = (0.31831 * (1.5708 - (
    sign(tmpvar_18.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_18.y)
    )) * (1.5708 + (
      abs(tmpvar_18.y)
     * 
      (-0.214602 + (abs(tmpvar_18.y) * (0.0865667 + (
        abs(tmpvar_18.y)
       * -0.0310296))))
    ))))
  )));
  float2 tmpvar_22;
  tmpvar_22 = ((uv_19 * 4.0) * _mtl_u._DetailScale);
  float2 tmpvar_23;
  tmpvar_23 = dfdx(tmpvar_18.xz);
  float2 tmpvar_24;
  tmpvar_24 = dfdy(tmpvar_18.xz);
  float4 tmpvar_25;
  tmpvar_25.x = (0.159155 * sqrt(dot (tmpvar_23, tmpvar_23)));
  tmpvar_25.y = dfdx(tmpvar_22.y);
  tmpvar_25.z = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_25.w = dfdy(tmpvar_22.y);
  float3 tmpvar_26;
  tmpvar_26 = abs(tmpvar_18);
  float tmpvar_27;
  tmpvar_27 = float((tmpvar_26.z >= tmpvar_26.x));
  zxlerp_17 = half(tmpvar_27);
  float tmpvar_28;
  tmpvar_28 = float((mix (tmpvar_26.x, tmpvar_26.z, (float)zxlerp_17) >= tmpvar_26.y));
  nylerp_16 = half(tmpvar_28);
  float3 tmpvar_29;
  tmpvar_29 = mix (tmpvar_26, tmpvar_26.zxy, (float3)half3(zxlerp_17));
  detailCoords_15 = half3(tmpvar_29);
  float3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_26.yxz, (float3)detailCoords_15, (float3)half3(nylerp_16));
  detailCoords_15 = half3(tmpvar_30);
  half tmpvar_31;
  tmpvar_31 = abs(detailCoords_15.x);
  float2 coord_32;
  coord_32 = ((float2)(((half)0.5 * detailCoords_15.zy) / tmpvar_31) * _mtl_u._DetailScale);
  half4 tmpvar_33;
  tmpvar_33 = _DetailTex.sample(_mtlsmp__DetailTex, (float2)(coord_32), gradient2d((float2)(tmpvar_25.xy), (float2)(tmpvar_25.zw)));
  tmpvar_14 = tmpvar_33;
  float4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = _mtl_u._WorldSpaceCameraPos;
  float4 tmpvar_35;
  tmpvar_35 = (_mtl_i.xlv_TEXCOORD3 - tmpvar_34);
  half tmpvar_36;
  float tmpvar_37;
  tmpvar_37 = clamp (((2.0 * _mtl_u._DetailDist) * sqrt(
    dot (tmpvar_35, tmpvar_35)
  )), 0.0, 1.0);
  tmpvar_36 = half(tmpvar_37);
  half4 tmpvar_38;
  tmpvar_38 = ((_mtl_u._Color * tmpvar_13) * mix (tmpvar_14, (half4)float4(1.0, 1.0, 1.0, 1.0), half4(tmpvar_36)));
  color_2 = tmpvar_38;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), (half)0.0, (half)1.0);
  color_2.xyz = half3(mix ((half)1.0, color_2.x, color_2.w));
  half4 tmpvar_39;
  tmpvar_39 = half4(mix ((half)1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_39;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
SubProgram "opengl " {
Keywords { "WORLD_SPACE_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 124 math, 6 textures
Keywords { "WORLD_SPACE_ON" }
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_Color]
Float 2 [_DetailScale]
Float 3 [_DetailDist]
Float 4 [_PlanetRadius]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c5, 1.00000000, 0.00000000, 5.00000000, -0.21211439
def c6, -0.01872930, 0.07426100, 1.57072902, 2.00000000
def c7, 3.14159298, 0.31830987, -0.01348047, 0.05747731
def c8, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c9, 1.57079601, 0.15915494, 0.50000000, 1.27323949
def c10, -1.00000000, 0, 0, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dp3 r0.x, v4, v4
rsq r0.x, r0.x
mul r1.xyz, r0.x, v4
abs r1.w, r1.z
abs r0.w, r1.x
max r0.y, r0.w, r1.w
min r0.x, r0.w, r1.w
add r0.w, r0, -r1
abs r1.w, r1.y
rcp r0.y, r0.y
mul r2.w, r0.x, r0.y
mul r4.x, r2.w, r2.w
mad r3.x, r4, c7.z, c7.w
mad r3.w, r3.x, r4.x, c8.x
dp3 r0.z, v5, v5
rsq r0.x, r0.z
mul r0.xyz, r0.x, v5
abs r2.xyz, r0
add r4.y, r2.z, -r2.x
mad r3.w, r3, r4.x, c8.y
cmp r1.y, r1, c5, c5.x
add r3.xyz, r2.zxyw, -r2
cmp r4.y, r4, c5.x, c5
mad r3.xyz, r4.y, r3, r2
mad r4.y, r3.w, r4.x, c8.z
add r4.z, r3.x, -r2.y
mad r4.x, r4.y, r4, c8.w
mul r2.w, r4.x, r2
dsy r4.xy, r1.xzzw
add r3.xyz, r3, -r2.yxzw
cmp r3.w, r4.z, c5.x, c5.y
mad r2.xyz, r3.w, r3, r2.yxzw
add r3.x, -r2.w, c9
cmp r0.w, -r0, r2, r3.x
dsx r3.zw, r1.xyxz
add r3.x, -r1.w, c5
mad r2.w, r1, c6.x, c6.y
mad r2.w, r2, r1, c5
rsq r3.x, r3.x
rcp r3.x, r3.x
mad r1.w, r2, r1, c6.z
mul r1.w, r1, r3.x
mul r2.w, r1.y, r1
add r3.x, -r0.w, c7
mad r1.w, -r2, c6, r1
cmp r2.w, r1.z, r0, r3.x
mad r0.w, r1.y, c7.x, r1
mul r0.w, r0, c7.y
cmp r1.y, r1.x, r2.w, -r2.w
mad r3.x, r1.y, c9.y, c9.z
mul r4.xy, r4, r4
add r1.x, r4, r4.y
rsq r1.x, r1.x
rcp r1.x, r1.x
mov r3.y, r0.w
dsy r1.y, r0.w
dsx r1.w, r0
mul r3.zw, r3, r3
add r0.w, r3.z, r3
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r1.z, r0.w, c9.y
abs_pp r0.w, r2.x
mul r1.x, r1, c9.y
texldd r1.xw, r3, s0, r1.zwzw, r1
abs r1.y, r0
add r2.x, -r1.y, c5
mad r1.z, r1.y, c6.x, c6.y
mad r1.z, r1, r1.y, c5.w
rsq r2.x, r2.x
rcp_pp r0.w, r0.w
rcp r2.x, r2.x
mad r1.y, r1.z, r1, c6.z
mul r1.y, r1, r2.x
mul_pp r2.xy, r2.zyzw, r0.w
dsx r2.zw, r0.xyxz
cmp r0.y, r0, c5, c5.x
mul r1.z, r0.y, r1.y
mad r0.w, -r1.z, c6, r1.y
mad r0.y, r0, c7.x, r0.w
mul r0.y, r0, c2.x
mul r1.z, r0.y, c9.w
add r3.xyz, -v3, c0
dp3 r0.y, r3, r3
rsq r1.y, r0.y
dsy r3.xy, r0.xzzw
mul_pp r2.xy, r2, c9.z
mul r2.zw, r2, r2
mul r3.xy, r3, r3
add r0.x, r2.z, r2.w
add r0.z, r3.x, r3.y
rsq r0.x, r0.x
dsy r0.y, r1.z
mul r2.xy, r2, c2.x
dsx r0.w, r1.z
rsq r0.z, r0.z
rcp r0.x, r0.x
rcp r1.z, r0.z
mul r0.z, r0.x, c9.y
mul r0.x, r1.z, c9.y
texldd r0.xw, r2, s1, r0.zwzw, r0
rcp r1.y, r1.y
mul r0.y, r1, c3.x
add_pp r2.xy, -r0.xwzw, c5.x
mul_sat r0.y, r0, c6.w
mad_pp r0.zw, r0.y, r2.xyxy, r0.xyxw
mul_pp r0.xy, r1.xwzw, c1.xwzw
mul_pp r0.xy, r0, r0.zwzw
add_pp_sat r0.x, r0, -r0.y
add_pp r0.z, r0.x, c10.x
add r0.x, v2, -c4
mul_pp r0.z, r0.y, r0
add r0.y, r0.x, c5.z
cmp r0.x, v0.w, c5, c5.y
cmp r0.y, r0, c5.x, c5
mul r0.x, r0, v1
mul_pp r0.x, r0, r0.y
mad_pp oC0, r0.x, r0.z, c5.x
"
}
SubProgram "d3d11 " {
// Stats: 105 math
Keywords { "WORLD_SPACE_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
ConstBuffer "$Globals" 352
Vector 192 [_Color]
Float 224 [_DetailScale]
Float 228 [_DetailDist]
Float 260 [_PlanetRadius]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedaaheddmjcjkdmjknkfcgcicjadhalnfpabaaaaaabiapaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaanaaaaeaaaaaaahiadaaaa
fjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadicbabaaa
abaaaaaagcbaaaadbcbabaaaacaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaigbbbaaaaeaaaaaa
deaaaaajicaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaaddaaaaajbcaabaaaabaaaaaabkaabaiaibaaaaaa
aaaaaaaaakaabaiaibaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaajecaabaaa
abaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadbaaaaai
dcaabaaaabaaaaaajgafbaaaaaaaaaaajgafbaiaebaaaaaaaaaaaaaaabaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejmaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadbaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaadeaaaaahecaabaaaabaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaabnaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadhaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaa
aaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaaaaaaaaaa
ckaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
iedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaiaibaaaaaa
aaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaaaaaaaaackaabaiambaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
abaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdoalaaaaaf
ccaabaaaabaaaaaabkaabaaaacaaaaaaamaaaaafccaabaaaadaaaaaabkaabaaa
acaaaaaaalaaaaafmcaabaaaaaaaaaaaagaebaaaaaaaaaaaamaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoapaaaaahbcaabaaa
aaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaa
idpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaadgaaaaafecaabaaa
abaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaapgapbaaaabaaaaaabgbjbaaaafaaaaaadgaaaaaghcaabaaa
adaaaaaajgahbaiambaaaaaaacaaaaaaaaaaaaaihcaabaaaaeaaaaaahgaobaia
ibaaaaaaacaaaaaaegacbaaaadaaaaaabnaaaaajicaabaaaabaaaaaadkaabaia
ibaaaaaaacaaaaaabkaabaiaibaaaaaaacaaaaaaabaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaadaaaaaackaabaaa
aeaaaaaadkaabaaaabaaaaaadcaaaaakdcaabaaaabaaaaaapgapbaaaabaaaaaa
egaabaaaaeaaaaaajgafbaiaibaaaaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaabgahbaaaadaaaaaaaaaaaaajbcaabaaaadaaaaaabkaabaia
mbaaaaaaacaaaaaadkaabaiaibaaaaaaacaaaaaadcaaaaakicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaabnaaaaai
icaabaaaabaaaaaadkaabaaaabaaaaaackaabaiaibaaaaaaacaaaaaaabaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaggalbaiaibaaaaaaacaaaaaa
diaaaaakgcaabaaaabaaaaaakgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaaaaaoaaaaahdcaabaaaabaaaaaajgafbaaaabaaaaaaagaabaaa
abaaaaaadcaaaaakecaabaaaabaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaabaaaaaackaabaaaabaaaaaa
akaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaabaaaaaa
ckaabaaaabaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpaaaaaaai
icaabaaaabaaaaaaakaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaa
abaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaaiecaabaaaacaaaaaackaabaaa
acaaaaaackaabaiaebaaaaaaacaaaaaaabaaaaahbcaabaaaacaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaidpjkcdpalaaaaafccaabaaaadaaaaaackaabaaaabaaaaaa
amaaaaafccaabaaaaeaaaaaackaabaaaabaaaaaaalaaaaafmcaabaaaabaaaaaa
fganbaaaacaaaaaaamaaaaafdcaabaaaacaaaaaangafbaaaacaaaaaaapaaaaah
bcaabaaaacaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaaacaaaaaa
abeaaaaaidpjccdoapaaaaahecaabaaaabaaaaaaogakbaaaabaaaaaaogakbaaa
abaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaa
adaaaaaackaabaaaabaaaaaaabeaaaaaidpjccdoejaaaaanpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaegaabaaaadaaaaaa
egaabaaaaeaaaaaaaaaaaaalpcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaaaaaaajhcaabaaaadaaaaaa
egbcbaaaadaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaadaaaaaa
akaabaaaadaaaaaaapcaaaaibcaabaaaadaaaaaaagaabaaaadaaaaaafgifcaaa
aaaaaaaaaoaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadccaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaapgapbaiaebaaaaaaacaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaapgapbaaaacaaaaaaaaaaaaakpcaabaaaaaaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaialpbnaaaaah
bcaabaaaabaaaaaadkbabaaaabaaaaaaabeaaaaaaaaaaaaaabaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaakbabaaaacaaaaaaaaaaaaahccaabaaaabaaaaaabkbabaaa
acaaaaaaabeaaaaaaaaakaeabnaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaaaaaaaaaaabaaaaaaaabaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaampccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab"
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
SubProgram "metal " {
// Stats: 159 math, 2 textures, 6 branches
Keywords { "WORLD_SPACE_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_DetailTex] 2D 1
ConstBuffer "$Globals" 36
Vector 0 [_WorldSpaceCameraPos] 3
VectorHalf 16 [_Color] 4
Float 24 [_DetailScale]
Float 28 [_DetailDist]
Float 32 [_PlanetRadius]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD1;
  float xlv_TEXCOORD2;
  float4 xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float4 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  half4 _Color;
  float _DetailScale;
  float _DetailDist;
  float _PlanetRadius;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _MainTex [[texture(0)]], sampler _mtlsmp__MainTex [[sampler(0)]]
  ,   texture2d<half> _DetailTex [[texture(1)]], sampler _mtlsmp__DetailTex [[sampler(1)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  half shadowCheck_3;
  float tmpvar_4;
  tmpvar_4 = (float((_mtl_i.xlv_TEXCOORD0.w >= 0.0)) * _mtl_i.xlv_TEXCOORD1);
  shadowCheck_3 = half(tmpvar_4);
  float tmpvar_5;
  tmpvar_5 = ((float)shadowCheck_3 * float((
    (_mtl_i.xlv_TEXCOORD2 + 5.0)
   >= _mtl_u._PlanetRadius)));
  shadowCheck_3 = half(tmpvar_5);
  float3 tmpvar_6;
  tmpvar_6 = normalize(_mtl_i.xlv_TEXCOORD4.xyz);
  float2 uv_7;
  float tmpvar_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    float tmpvar_9;
    tmpvar_9 = (tmpvar_6.x / tmpvar_6.z);
    tmpvar_8 = (tmpvar_9 * rsqrt((
      (tmpvar_9 * tmpvar_9)
     + 1.0)));
    tmpvar_8 = (sign(tmpvar_8) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_8)))
     * 
      (1.5708 + (abs(tmpvar_8) * (-0.214602 + (
        abs(tmpvar_8)
       * 
        (0.0865667 + (abs(tmpvar_8) * -0.0310296))
      ))))
    )));
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        tmpvar_8 += 3.14159;
      } else {
        tmpvar_8 = (tmpvar_8 - 3.14159);
      };
    };
  } else {
    tmpvar_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * tmpvar_8));
  uv_7.y = (0.31831 * (1.5708 - (
    sign(tmpvar_6.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_6.y)
    )) * (1.5708 + (
      abs(tmpvar_6.y)
     * 
      (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (
        abs(tmpvar_6.y)
       * -0.0310296))))
    ))))
  )));
  float2 tmpvar_10;
  tmpvar_10 = dfdx(tmpvar_6.xz);
  float2 tmpvar_11;
  tmpvar_11 = dfdy(tmpvar_6.xz);
  float4 tmpvar_12;
  tmpvar_12.x = (0.159155 * sqrt(dot (tmpvar_10, tmpvar_10)));
  tmpvar_12.y = dfdx(uv_7.y);
  tmpvar_12.z = (0.159155 * sqrt(dot (tmpvar_11, tmpvar_11)));
  tmpvar_12.w = dfdy(uv_7.y);
  half4 tmpvar_13;
  tmpvar_13 = _MainTex.sample(_mtlsmp__MainTex, (float2)(uv_7), gradient2d((float2)(tmpvar_12.xy), (float2)(tmpvar_12.zw)));
  half4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  half4 tmpvar_15;
  half3 detailCoords_16;
  half nylerp_17;
  half zxlerp_18;
  float3 tmpvar_19;
  tmpvar_19 = normalize(_mtl_i.xlv_TEXCOORD5.xyz);
  float2 uv_20;
  float tmpvar_21;
  if ((abs(tmpvar_19.z) > (1e-08 * abs(tmpvar_19.x)))) {
    float tmpvar_22;
    tmpvar_22 = (tmpvar_19.x / tmpvar_19.z);
    tmpvar_21 = (tmpvar_22 * rsqrt((
      (tmpvar_22 * tmpvar_22)
     + 1.0)));
    tmpvar_21 = (sign(tmpvar_21) * (1.5708 - (
      sqrt((1.0 - abs(tmpvar_21)))
     * 
      (1.5708 + (abs(tmpvar_21) * (-0.214602 + (
        abs(tmpvar_21)
       * 
        (0.0865667 + (abs(tmpvar_21) * -0.0310296))
      ))))
    )));
    if ((tmpvar_19.z < 0.0)) {
      if ((tmpvar_19.x >= 0.0)) {
        tmpvar_21 += 3.14159;
      } else {
        tmpvar_21 = (tmpvar_21 - 3.14159);
      };
    };
  } else {
    tmpvar_21 = (sign(tmpvar_19.x) * 1.5708);
  };
  uv_20.x = (0.5 + (0.159155 * tmpvar_21));
  uv_20.y = (0.31831 * (1.5708 - (
    sign(tmpvar_19.y)
   * 
    (1.5708 - (sqrt((1.0 - 
      abs(tmpvar_19.y)
    )) * (1.5708 + (
      abs(tmpvar_19.y)
     * 
      (-0.214602 + (abs(tmpvar_19.y) * (0.0865667 + (
        abs(tmpvar_19.y)
       * -0.0310296))))
    ))))
  )));
  float2 tmpvar_23;
  tmpvar_23 = ((uv_20 * 4.0) * _mtl_u._DetailScale);
  float2 tmpvar_24;
  tmpvar_24 = dfdx(tmpvar_19.xz);
  float2 tmpvar_25;
  tmpvar_25 = dfdy(tmpvar_19.xz);
  float4 tmpvar_26;
  tmpvar_26.x = (0.159155 * sqrt(dot (tmpvar_24, tmpvar_24)));
  tmpvar_26.y = dfdx(tmpvar_23.y);
  tmpvar_26.z = (0.159155 * sqrt(dot (tmpvar_25, tmpvar_25)));
  tmpvar_26.w = dfdy(tmpvar_23.y);
  float3 tmpvar_27;
  tmpvar_27 = abs(tmpvar_19);
  float tmpvar_28;
  tmpvar_28 = float((tmpvar_27.z >= tmpvar_27.x));
  zxlerp_18 = half(tmpvar_28);
  float tmpvar_29;
  tmpvar_29 = float((mix (tmpvar_27.x, tmpvar_27.z, (float)zxlerp_18) >= tmpvar_27.y));
  nylerp_17 = half(tmpvar_29);
  float3 tmpvar_30;
  tmpvar_30 = mix (tmpvar_27, tmpvar_27.zxy, (float3)half3(zxlerp_18));
  detailCoords_16 = half3(tmpvar_30);
  float3 tmpvar_31;
  tmpvar_31 = mix (tmpvar_27.yxz, (float3)detailCoords_16, (float3)half3(nylerp_17));
  detailCoords_16 = half3(tmpvar_31);
  half tmpvar_32;
  tmpvar_32 = abs(detailCoords_16.x);
  float2 coord_33;
  coord_33 = ((float2)(((half)0.5 * detailCoords_16.zy) / tmpvar_32) * _mtl_u._DetailScale);
  half4 tmpvar_34;
  tmpvar_34 = _DetailTex.sample(_mtlsmp__DetailTex, (float2)(coord_33), gradient2d((float2)(tmpvar_26.xy), (float2)(tmpvar_26.zw)));
  tmpvar_15 = tmpvar_34;
  float4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _mtl_u._WorldSpaceCameraPos;
  float4 tmpvar_36;
  tmpvar_36 = (_mtl_i.xlv_TEXCOORD3 - tmpvar_35);
  half tmpvar_37;
  float tmpvar_38;
  tmpvar_38 = clamp (((2.0 * _mtl_u._DetailDist) * sqrt(
    dot (tmpvar_36, tmpvar_36)
  )), 0.0, 1.0);
  tmpvar_37 = half(tmpvar_38);
  half4 tmpvar_39;
  tmpvar_39 = ((_mtl_u._Color * tmpvar_14) * mix (tmpvar_15, (half4)float4(1.0, 1.0, 1.0, 1.0), half4(tmpvar_37)));
  color_2 = tmpvar_39;
  color_2.xyz = clamp ((color_2.xyz - color_2.w), (half)0.0, (half)1.0);
  color_2.xyz = half3(mix ((half)1.0, color_2.x, color_2.w));
  half4 tmpvar_40;
  tmpvar_40 = half4(mix ((half)1.0, color_2.x, shadowCheck_3));
  tmpvar_1 = tmpvar_40;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
}
 }
}
}