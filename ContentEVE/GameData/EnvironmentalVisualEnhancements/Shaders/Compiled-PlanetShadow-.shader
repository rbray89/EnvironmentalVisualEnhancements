// Compiled shader for all platforms, uncompressed size: 18.2KB

Shader "EVE/PlanetShadow" {
Properties {
 _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
 _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
 _PlanetRadius ("Planet Radius", Float) = 1
}
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 20 math
 //        d3d9 : 25 math
 //        gles : 21 math
 //       gles3 : 21 math
 //   glesdesktop : 21 math
 //       metal : 12 math
 //      opengl : 21 math
 // Stats for Fragment shader:
 //       d3d11 : 16 math
 //        d3d9 : 16 math
 //       metal : 21 math
 Pass {
  ZWrite Off
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
// Stats: 21 math
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform vec4 _SunDir;
uniform vec3 _PlanetOrigin;
uniform mat4 _Projector;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  float tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = gl_Normal;
  vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (_Object2World * tmpvar_4).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = -(dot (_SunDir, tmpvar_5));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _SunDir;
uniform float _PlanetRadius;
varying vec4 xlv_TEXCOORD0;
varying float xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 color_1;
  float tmpvar_2;
  tmpvar_2 = dot (xlv_TEXCOORD5, -(_SunDir).xyz);
  float tmpvar_3;
  tmpvar_3 = (float((_PlanetRadius >= 
    sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_2 * tmpvar_2)))
  )) * float((tmpvar_2 >= 0.0)));
  vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_3;
  color_1.xyz = tmpvar_4.xyz;
  color_1.w = (1.2 * (1.2 - tmpvar_3));
  vec4 tmpvar_5;
  tmpvar_5 = clamp (color_1, 0.0, 1.0);
  color_1 = tmpvar_5;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_5.w, (float(
    (xlv_TEXCOORD0.w >= 0.0)
  ) * float(
    (xlv_TEXCOORD3 >= 0.0)
  ))));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 25 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_Projector]
Vector 12 [_SunDir]
Vector 13 [_PlanetOrigin]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord2 o2
dcl_texcoord3 o3
dcl_texcoord4 o4
dcl_texcoord5 o5
def c14, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c14.x
mov r1.xyz, v1
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.w, r0, c12
mov o3.x, -r0.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r1.xyz, -r0, c13
dp3 r1.w, r1, r1
dp4 r0.w, v0, c7
rsq r1.w, r1.w
mov o4, r0
rcp o2.x, r1.w
mov o5.xyz, r1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c11
dp4 o1.z, v0, c10
dp4 o1.y, v0, c9
dp4 o1.x, v0, c8
"
}
SubProgram "d3d11 " {
// Stats: 20 math
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 320
Matrix 256 [_Projector]
Vector 224 [_SunDir]
Vector 244 [_PlanetOrigin] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedincjcnbdmmloddnfemehgllikemcghkmabaaaaaaniaeaaaaadaaaaaa
cmaaaaaahmaaaaaaemabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabapaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aealaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcieadaaaaeaaaabaaobaaaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadcccabaaaacaaaaaagfaaaaad
eccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabcaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaa
aaaaaaaabdaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaa
egacbaaaaaaaaaaadgaaaaageccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaajgihcaaaaaaaaaaaapaaaaaadgaaaaaf
pccabaaaadaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaabaaaaaa
elaaaaafcccabaaaacaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 21 math
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _SunDir;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (_Object2World * tmpvar_4).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = -(dot (_SunDir, tmpvar_5));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _SunDir;
uniform highp float _PlanetRadius;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float sphereCheck_3;
  mediump float shadowCheck_4;
  highp float tmpvar_5;
  tmpvar_5 = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD3 >= 0.0)));
  shadowCheck_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, -(_SunDir).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (float((_PlanetRadius >= 
    sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)))
  )) * float((tmpvar_6 >= 0.0)));
  sphereCheck_3 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = sphereCheck_3;
  color_2 = tmpvar_8;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_9;
  tmpvar_9 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(mix (1.0, tmpvar_9.w, shadowCheck_4));
  tmpvar_1 = tmpvar_10;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
// Stats: 21 math
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _SunDir;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (_Object2World * tmpvar_4).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = -(dot (_SunDir, tmpvar_5));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _SunDir;
uniform highp float _PlanetRadius;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float sphereCheck_3;
  mediump float shadowCheck_4;
  highp float tmpvar_5;
  tmpvar_5 = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD3 >= 0.0)));
  shadowCheck_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, -(_SunDir).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (float((_PlanetRadius >= 
    sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)))
  )) * float((tmpvar_6 >= 0.0)));
  sphereCheck_3 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = sphereCheck_3;
  color_2 = tmpvar_8;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_9;
  tmpvar_9 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(mix (1.0, tmpvar_9.w, shadowCheck_4));
  tmpvar_1 = tmpvar_10;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
// Stats: 21 math
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 _SunDir;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp float xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
out highp vec3 xlv_TEXCOORD5;
void main ()
{
  highp float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (_Object2World * tmpvar_4).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = -(dot (_SunDir, tmpvar_5));
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _SunDir;
uniform highp float _PlanetRadius;
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float sphereCheck_3;
  mediump float shadowCheck_4;
  highp float tmpvar_5;
  tmpvar_5 = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD3 >= 0.0)));
  shadowCheck_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD5, -(_SunDir).xyz);
  highp float tmpvar_7;
  tmpvar_7 = (float((_PlanetRadius >= 
    sqrt((dot (xlv_TEXCOORD5, xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)))
  )) * float((tmpvar_6 >= 0.0)));
  sphereCheck_3 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = sphereCheck_3;
  color_2 = tmpvar_8;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_9;
  tmpvar_9 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(mix (1.0, tmpvar_9.w, shadowCheck_4));
  tmpvar_1 = tmpvar_10;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "metal " {
// Stats: 12 math
Bind "vertex" ATTR0
Bind "normal" ATTR1
ConstBuffer "$Globals" 224
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
Matrix 160 [_Projector]
Vector 128 [_SunDir]
Vector 144 [_PlanetOrigin] 3
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
  float3 _glesNormal [[attribute(1)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD1;
  float xlv_TEXCOORD2;
  float xlv_TEXCOORD3;
  float4 xlv_TEXCOORD4;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
  float4 _SunDir;
  float3 _PlanetOrigin;
  float4x4 _Projector;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float tmpvar_1;
  float4 tmpvar_2;
  tmpvar_2 = (_mtl_u._Object2World * _mtl_i._glesVertex);
  float3 tmpvar_3;
  tmpvar_3 = (_mtl_u._PlanetOrigin - tmpvar_2.xyz);
  float4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_mtl_i._glesNormal);
  float4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = (_mtl_u._Object2World * tmpvar_4).xyz;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Projector * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD1 = tmpvar_1;
  _mtl_o.xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  _mtl_o.xlv_TEXCOORD3 = -(dot (_mtl_u._SunDir, tmpvar_5));
  _mtl_o.xlv_TEXCOORD4 = tmpvar_2;
  _mtl_o.xlv_TEXCOORD5 = tmpvar_3;
  return _mtl_o;
}

"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 16 math
Vector 0 [_SunDir]
Float 1 [_PlanetRadius]
"ps_3_0
def c2, 1.00000000, 0.00000000, 1.20019531, -1.00000000
dcl_texcoord0 v0.xyzw
dcl_texcoord3 v1.x
dcl_texcoord5 v2.xyz
dp3 r0.x, v2, -c0
dp3 r0.y, v2, v2
mad r0.y, -r0.x, r0.x, r0
rsq r0.y, r0.y
rcp r0.y, r0.y
cmp r0.z, r0.x, c2.x, c2.y
add r0.y, -r0, c1.x
cmp r0.x, r0.y, c2, c2.y
mul r0.x, r0, r0.z
add_pp r0.x, -r0, c2.z
mul_pp_sat r0.x, r0, c2.z
add_pp r0.z, r0.x, c2.w
cmp r0.y, v1.x, c2.x, c2
cmp r0.x, v0.w, c2, c2.y
mul r0.x, r0, r0.y
mad_pp oC0, r0.x, r0.z, c2.x
"
}
SubProgram "d3d11 " {
// Stats: 16 math
ConstBuffer "$Globals" 320
Vector 224 [_SunDir]
Float 240 [_PlanetRadius]
BindCB  "$Globals" 0
"ps_4_0
eefiecednnmbbdkliahdbhiepjaejnlfkcjpohfdabaaaaaajeadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
abaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
ecbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaabaaaaaajccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaiaebaaaaaa
aaaaaaaaaoaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bnaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaapaaaaaaakaabaaaaaaaaaaa
abaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaajkjjjjdpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaajkjjjjdpddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaialpbnaaaaahccaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaackbabaaaacaaaaaaabeaaaaaaaaaaaaaabaaaaak
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadp
aaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaampccabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "metal " {
// Stats: 21 math
ConstBuffer "$Globals" 20
Vector 0 [_SunDir]
Float 16 [_PlanetRadius]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 xlv_TEXCOORD0;
  float xlv_TEXCOORD3;
  float3 xlv_TEXCOORD5;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float4 _SunDir;
  float _PlanetRadius;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  half4 tmpvar_1;
  half4 color_2;
  half sphereCheck_3;
  half shadowCheck_4;
  float tmpvar_5;
  tmpvar_5 = (float((_mtl_i.xlv_TEXCOORD0.w >= 0.0)) * float((_mtl_i.xlv_TEXCOORD3 >= 0.0)));
  shadowCheck_4 = half(tmpvar_5);
  float tmpvar_6;
  tmpvar_6 = dot (_mtl_i.xlv_TEXCOORD5, -(_mtl_u._SunDir).xyz);
  float tmpvar_7;
  tmpvar_7 = (float((_mtl_u._PlanetRadius >= 
    sqrt((dot (_mtl_i.xlv_TEXCOORD5, _mtl_i.xlv_TEXCOORD5) - (tmpvar_6 * tmpvar_6)))
  )) * float((tmpvar_6 >= 0.0)));
  sphereCheck_3 = half(tmpvar_7);
  half4 tmpvar_8;
  tmpvar_8.xyz = half3(float3(1.0, 1.0, 1.0));
  tmpvar_8.w = sphereCheck_3;
  color_2 = tmpvar_8;
  color_2.w = ((half)1.2 * ((half)1.2 - color_2.w));
  half4 tmpvar_9;
  tmpvar_9 = clamp (color_2, (half)0.0, (half)1.0);
  color_2 = tmpvar_9;
  half4 tmpvar_10;
  tmpvar_10 = half4(mix ((half)1.0, tmpvar_9.w, shadowCheck_4));
  tmpvar_1 = tmpvar_10;
  _mtl_o._glesFragData_0 = tmpvar_1;
  return _mtl_o;
}

"
}
}
 }
}
}