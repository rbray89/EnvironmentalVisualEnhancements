Shader "EVE/CloudShadow" {
   Properties {
      _MainTex ("Main (RGB)", 2D) = "white" {}
      _DetailTex ("Detail (RGB)", 2D) = "white" {}
      _DetailScale ("Detail Scale", float) = 100
	  _DetailDist ("Detail Distance", Range(0,1)) = 0.00875
	  _PlanetOrigin ("Sphere Center", Vector) = (0,0,0,1)
	  _SunDir ("Sunlight direction", Vector) = (0,0,0,1)
	  _Radius ("Radius", Float) = 1
   }
   SubShader {
      Pass {      
        Blend DstColor Zero
        ZWrite Off
        Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 41 to 41
//   d3d11 - ALU: 39 to 39, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;
uniform vec3 _PlanetOrigin;
uniform float _Radius;
uniform vec4 _SunDir;
uniform mat4 _MainRotation;
uniform mat4 _Object2World;

void main ()
{
  vec3 tmpvar_1;
  tmpvar_1.x = _Projector[0].z;
  tmpvar_1.y = _Projector[1].z;
  tmpvar_1.z = _Projector[2].z;
  vec4 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_PlanetOrigin - tmpvar_2.xyz);
  float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, _SunDir.xyz);
  float tmpvar_5;
  tmpvar_5 = sqrt((dot (tmpvar_3, tmpvar_3) - (tmpvar_4 * tmpvar_4)));
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 + (_SunDir * mix (0.0, (tmpvar_4 - sqrt(((_Radius * _Radius) - pow (tmpvar_5, 2.0)))), (float((_Radius >= tmpvar_5)) * float((tmpvar_4 >= 0.0))))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = dot (-(normalize(tmpvar_3)), normalize(tmpvar_1));
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_3, tmpvar_3));
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = -((_MainRotation * tmpvar_6));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD2;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Radius;
uniform sampler2D _MainTex;
void main ()
{
  vec4 color_1;
  float dirCheck_2;
  dirCheck_2 = ((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2)));
  vec3 tmpvar_3;
  tmpvar_3 = normalize(xlv_TEXCOORD4.xyz);
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
  vec4 tmpvar_12;
  tmpvar_12 = texture2DGradARB (_MainTex, uv_4, tmpvar_11.xy, tmpvar_11.zw);
  color_1.xyz = tmpvar_12.xyz;
  color_1.w = (1.2 * (1.2 - tmpvar_12.w));
  vec4 tmpvar_13;
  tmpvar_13 = clamp (color_1, 0.0, 1.0);
  color_1 = tmpvar_13;
  gl_FragData[0] = vec4(mix (1.0, tmpvar_13.w, dirCheck_2));
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
Vector 16 [_SunDir]
Float 17 [_Radius]
Vector 18 [_PlanetOrigin]
Matrix 12 [_Projector]
"vs_3_0
; 41 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c19, 0.00000000, 0, 0, 0
dcl_position0 v0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r2.xyz, -r0, c18
dp3 r0.w, r2, c16
dp3 r2.w, r2, r2
mad r1.x, -r0.w, r0.w, r2.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r1.y, r1.x, r1.x
mad r1.y, c17.x, c17.x, -r1
rsq r1.y, r1.y
rcp r1.z, r1.y
sge r1.y, r0.w, c19.x
sge r1.x, c17, r1
mul r1.x, r1, r1.y
add r1.y, r0.w, -r1.z
dp4 r0.w, v0, c7
mul r1.x, r1, r1.y
mad r1, r1.x, c16, r0
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mov o5, -r0
rsq r0.w, r2.w
dp3 r3.x, c14, c14
rsq r0.x, r3.x
mul r0.xyz, r0.x, c14
mul r2.xyz, r0.w, r2
dp3 o2.x, -r2, r0
mov o4, r1
rcp o3.x, r0.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.w, v0, c15
dp4 o1.z, v0, c14
dp4 o1.y, v0, c13
dp4 o1.x, v0, c12
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
ConstBuffer "$Globals" 288 // 288 used size, 11 vars
Matrix 16 [_MainRotation] 4
Vector 192 [_SunDir] 4
Float 208 [_Radius]
Vector 212 [_PlanetOrigin] 3
Matrix 224 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 44 instructions, 4 temp regs, 0 temp arrays:
// ALU 38 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgfmmdeeedgjffeaaaolbabgnjoemoplmabaaaaaacmahaaaaadaaaaaa
cmaaaaaahmaaaaaadeabaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaacanaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpaafaaaaeaaaabaa
hmabaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadbccabaaaacaaaaaagfaaaaadcccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaapaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaaoaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaaaaaaaaa
bbaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaagbcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaadgaaaaagccaabaaaaaaaaaaackiacaaaaaaaaaaa
apaaaaaadgaaaaagecaabaaaaaaaaaaackiacaaaaaaaaaaabaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaajgihcaaaaaaaaaaa
anaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaaibccabaaaacaaaaaaegacbaia
ebaaaaaaadaaaaaaegacbaaaaaaaaaaaelaaaaafcccabaaaacaaaaaadkaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bnaaaaahccaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaabnaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaambcaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaakiacaaaaaaaaaaaanaaaaaaakaabaia
ebaaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaaabaaaaak
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadp
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadgaaaaagpccabaaaaeaaaaaaegaobaia
ebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Radius;
uniform highp vec4 _SunDir;
uniform highp mat4 _MainRotation;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesVertex;
void main ()
{
  mediump float sphereCheck_1;
  highp vec3 tmpvar_2;
  tmpvar_2.x = _Projector[0].z;
  tmpvar_2.y = _Projector[1].z;
  tmpvar_2.z = _Projector[2].z;
  highp vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_PlanetOrigin - tmpvar_3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, _SunDir.xyz);
  highp float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_4, tmpvar_4) - (tmpvar_5 * tmpvar_5)));
  highp float tmpvar_7;
  tmpvar_7 = (float((_Radius >= tmpvar_6)) * float((tmpvar_5 >= 0.0)));
  sphereCheck_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_3 + (_SunDir * mix (0.0, (tmpvar_5 - sqrt(((_Radius * _Radius) - pow (tmpvar_6, 2.0)))), sphereCheck_1)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = dot (-(normalize(tmpvar_4)), normalize(tmpvar_2));
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = -((_MainRotation * tmpvar_8));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Radius;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float dirCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = ((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2)));
  dirCheck_3 = tmpvar_4;
  mediump vec4 tex_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_7;
  highp float r_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (tmpvar_6.x / tmpvar_6.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * r_8));
  uv_7.y = (0.31831 * (1.5708 - (sign(tmpvar_6.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_6.y))) * (1.5708 + (abs(tmpvar_6.y) * (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (abs(tmpvar_6.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_12;
  tmpvar_12 = dFdx(tmpvar_6.xz);
  highp vec2 tmpvar_13;
  tmpvar_13 = dFdy(tmpvar_6.xz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(uv_7.y);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(uv_7.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DGradEXT (_MainTex, uv_7, tmpvar_14.xy, tmpvar_14.zw);
  tex_5 = tmpvar_15;
  color_2 = tex_5;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_16;
  tmpvar_16 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = vec4(mix (1.0, tmpvar_16.w, dirCheck_3));
  tmpvar_1 = tmpvar_17;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec3 _PlanetOrigin;
uniform highp float _Radius;
uniform highp vec4 _SunDir;
uniform highp mat4 _MainRotation;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesVertex;
void main ()
{
  mediump float sphereCheck_1;
  highp vec3 tmpvar_2;
  tmpvar_2.x = _Projector[0].z;
  tmpvar_2.y = _Projector[1].z;
  tmpvar_2.z = _Projector[2].z;
  highp vec4 tmpvar_3;
  tmpvar_3 = (_Object2World * _glesVertex);
  highp vec3 tmpvar_4;
  tmpvar_4 = (_PlanetOrigin - tmpvar_3.xyz);
  highp float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, _SunDir.xyz);
  highp float tmpvar_6;
  tmpvar_6 = sqrt((dot (tmpvar_4, tmpvar_4) - (tmpvar_5 * tmpvar_5)));
  highp float tmpvar_7;
  tmpvar_7 = (float((_Radius >= tmpvar_6)) * float((tmpvar_5 >= 0.0)));
  sphereCheck_1 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_3 + (_SunDir * mix (0.0, (tmpvar_5 - sqrt(((_Radius * _Radius) - pow (tmpvar_6, 2.0)))), sphereCheck_1)));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = dot (-(normalize(tmpvar_4)), normalize(tmpvar_2));
  xlv_TEXCOORD2 = sqrt(dot (tmpvar_4, tmpvar_4));
  xlv_TEXCOORD3 = tmpvar_8;
  xlv_TEXCOORD4 = -((_MainRotation * tmpvar_8));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
#extension GL_OES_standard_derivatives : enable
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Radius;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 color_2;
  mediump float dirCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = ((float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0))) * float((_Radius >= xlv_TEXCOORD2)));
  dirCheck_3 = tmpvar_4;
  mediump vec4 tex_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4.xyz);
  highp vec2 uv_7;
  highp float r_8;
  if ((abs(tmpvar_6.z) > (1e-08 * abs(tmpvar_6.x)))) {
    highp float y_over_x_9;
    y_over_x_9 = (tmpvar_6.x / tmpvar_6.z);
    highp float s_10;
    highp float x_11;
    x_11 = (y_over_x_9 * inversesqrt(((y_over_x_9 * y_over_x_9) + 1.0)));
    s_10 = (sign(x_11) * (1.5708 - (sqrt((1.0 - abs(x_11))) * (1.5708 + (abs(x_11) * (-0.214602 + (abs(x_11) * (0.0865667 + (abs(x_11) * -0.0310296)))))))));
    r_8 = s_10;
    if ((tmpvar_6.z < 0.0)) {
      if ((tmpvar_6.x >= 0.0)) {
        r_8 = (s_10 + 3.14159);
      } else {
        r_8 = (r_8 - 3.14159);
      };
    };
  } else {
    r_8 = (sign(tmpvar_6.x) * 1.5708);
  };
  uv_7.x = (0.5 + (0.159155 * r_8));
  uv_7.y = (0.31831 * (1.5708 - (sign(tmpvar_6.y) * (1.5708 - (sqrt((1.0 - abs(tmpvar_6.y))) * (1.5708 + (abs(tmpvar_6.y) * (-0.214602 + (abs(tmpvar_6.y) * (0.0865667 + (abs(tmpvar_6.y) * -0.0310296)))))))))));
  highp vec2 tmpvar_12;
  tmpvar_12 = dFdx(tmpvar_6.xz);
  highp vec2 tmpvar_13;
  tmpvar_13 = dFdy(tmpvar_6.xz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = (0.159155 * sqrt(dot (tmpvar_12, tmpvar_12)));
  tmpvar_14.y = dFdx(uv_7.y);
  tmpvar_14.z = (0.159155 * sqrt(dot (tmpvar_13, tmpvar_13)));
  tmpvar_14.w = dFdy(uv_7.y);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DGradEXT (_MainTex, uv_7, tmpvar_14.xy, tmpvar_14.zw);
  tex_5 = tmpvar_15;
  color_2 = tex_5;
  color_2.w = (1.2 * (1.2 - color_2.w));
  lowp vec4 tmpvar_16;
  tmpvar_16 = clamp (color_2, 0.0, 1.0);
  color_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = vec4(mix (1.0, tmpvar_16.w, dirCheck_3));
  tmpvar_1 = tmpvar_17;
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
#line 379
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    highp float originDist;
    highp vec4 worldPos;
    highp vec4 mainPos;
};
#line 373
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
#line 365
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 369
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 389
#line 413
#line 389
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 393
    o.pos = (glstate_matrix_mvp * v.vertex);
    highp vec3 normView = normalize(vec3( _Projector[0][2], _Projector[1][2], _Projector[2][2]));
    highp vec4 vertexPos = (_Object2World * v.vertex);
    o.worldPos = vertexPos;
    #line 397
    highp vec3 worldOrigin = _PlanetOrigin;
    highp vec3 L = (worldOrigin - vec3( vertexPos));
    o.dotcoeff = dot( (-normalize(L)), normView);
    o.originDist = length(L);
    #line 401
    highp float tc = dot( L, vec3( _SunDir));
    highp float d = sqrt((dot( L, L) - (tc * tc)));
    highp float d2 = pow( d, 2.0);
    highp float td = sqrt((dot( L, L) - d2));
    #line 405
    highp float sphereRadius = _Radius;
    mediump float sphereCheck = (step( d, sphereRadius) * step( 0.0, tc));
    highp float tlc = sqrt(((sphereRadius * sphereRadius) - d2));
    highp float sphereDist = mix( 0.0, (tc - tlc), sphereCheck);
    #line 409
    o.worldPos = (vertexPos + (_SunDir * sphereDist));
    o.mainPos = (-(_MainRotation * o.worldPos));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp float xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
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
#line 379
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float dotcoeff;
    highp float originDist;
    highp vec4 worldPos;
    highp vec4 mainPos;
};
#line 373
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
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
#line 365
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
uniform highp float _DetailScale;
uniform highp float _DetailDist;
#line 369
uniform highp vec4 _SunDir;
uniform highp float _Radius;
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 389
#line 413
#line 317
highp vec4 Derivatives( in highp float lat, in highp float lon, in highp vec3 pos ) {
    #line 319
    highp vec2 latLong = vec2( lat, lon);
    highp float latDdx = (0.159155 * length(xll_dFdx_vf2(pos.xz)));
    highp float latDdy = (0.159155 * length(xll_dFdy_vf2(pos.xz)));
    highp float longDdx = xll_dFdx_f(lon);
    #line 323
    highp float longDdy = xll_dFdy_f(lon);
    return vec4( latDdx, longDdx, latDdy, longDdy);
}
#line 326
highp vec2 GetSphereUV( in highp vec3 sphereVect, in highp vec2 uvOffset ) {
    #line 328
    highp vec2 uv;
    uv.x = (0.5 + (0.159155 * atan( sphereVect.x, sphereVect.z)));
    uv.y = (0.31831 * acos(sphereVect.y));
    uv += uvOffset;
    #line 332
    return uv;
}
#line 343
mediump vec4 GetSphereMap( in sampler2D texSampler, in highp vec3 sphereVect ) {
    #line 345
    highp vec3 sphereVectNorm = normalize(sphereVect);
    highp vec2 uv = GetSphereUV( sphereVectNorm, vec2( 0.0, 0.0));
    highp vec4 uvdd = Derivatives( (uv.x - 0.5), uv.y, sphereVectNorm);
    mediump vec4 tex = xll_tex2Dgrad( texSampler, uv, uvdd.xy, uvdd.zw);
    #line 349
    return tex;
}
#line 413
lowp vec4 frag( in v2f IN ) {
    mediump float dirCheck = ((step( 0.0, IN.posProj.w) * step( 0.0, IN.dotcoeff)) * step( IN.originDist, _Radius));
    mediump vec4 main = GetSphereMap( _MainTex, vec3( IN.mainPos));
    #line 417
    lowp vec4 color = main;
    color.w = (1.2 * (1.2 - color.w));
    color = xll_saturate_vf4(color);
    return vec4( mix( 1.0, color.w, dirCheck));
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
in highp float xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.dotcoeff = float(xlv_TEXCOORD1);
    xlt_IN.originDist = float(xlv_TEXCOORD2);
    xlt_IN.worldPos = vec4(xlv_TEXCOORD3);
    xlt_IN.mainPos = vec4(xlv_TEXCOORD4);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 65 to 65, TEX: 3 to 3
//   d3d11 - ALU: 57 to 57, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
Float 0 [_Radius]
SetTexture 0 [_MainTex] 2D
"ps_3_0
; 65 ALU, 3 TEX
dcl_2d s0
def c1, 1.00000000, 0.00000000, -0.01348047, 0.05747731
def c2, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c3, 1.57079601, 3.14159298, -0.01872930, 0.07426100
def c4, -0.21211439, 1.57072902, 2.00000000, 0.31830987
def c5, 0.15915494, 0.50000000, 1.20019531, -1.00000000
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
dcl_texcoord2 v2.x
dcl_texcoord4 v3.xyz
dp3 r0.x, v3, v3
rsq r0.x, r0.x
mul r0.xyz, r0.x, v3
abs r0.w, r0.z
abs r1.x, r0
max r1.y, r1.x, r0.w
rcp r1.z, r1.y
min r1.y, r1.x, r0.w
mul r1.y, r1, r1.z
mul r1.z, r1.y, r1.y
add r1.x, r1, -r0.w
abs r0.w, r0.y
mad r1.w, r1.z, c1.z, c1
mad r1.w, r1, r1.z, c2.x
mad r1.w, r1, r1.z, c2.y
mad r1.w, r1, r1.z, c2.z
mad r1.z, r1.w, r1, c2.w
mul r1.y, r1.z, r1
add r1.z, -r1.y, c3.x
cmp r1.x, -r1, r1.y, r1.z
add r1.z, -r0.w, c1.x
mad r1.y, r0.w, c3.z, c3.w
mad r1.y, r1, r0.w, c4.x
rsq r1.z, r1.z
rcp r1.z, r1.z
mad r0.w, r1.y, r0, c4.y
mul r0.w, r0, r1.z
add r1.z, -r1.x, c3.y
cmp r1.x, r0.z, r1, r1.z
cmp r0.y, r0, c1, c1.x
mul r1.y, r0, r0.w
mad r0.w, -r1.y, c4.z, r0
mad r0.y, r0, c3, r0.w
cmp r0.w, r0.x, r1.x, -r1.x
dsx r1.zw, r0.xyxz
mul r0.y, r0, c4.w
mad r1.x, r0.w, c5, c5.y
dsy r0.xz, r0
mul r0.xz, r0, r0
add r0.z, r0.x, r0
mul r1.zw, r1, r1
add r1.z, r1, r1.w
rsq r0.x, r1.z
rsq r0.z, r0.z
mov r1.y, r0
dsx r0.w, r0.y
dsy r0.y, r0
rcp r0.x, r0.x
rcp r1.z, r0.z
mul r0.z, r0.x, c5.x
mul r0.x, r1.z, c5
texldd r0.w, r1, s0, r0.zwzw, r0
add_pp r0.x, -r0.w, c5.z
mul_pp_sat r0.y, r0.x, c5.z
add r0.x, -v2, c0
add_pp r0.w, r0.y, c5
cmp r0.z, r0.x, c1.x, c1.y
cmp r0.y, v1.x, c1.x, c1
cmp r0.x, v0.w, c1, c1.y
mul r0.x, r0, r0.y
mul r0.x, r0, r0.z
mad_pp oC0, r0.x, r0.w, c1.x
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 288 // 212 used size, 11 vars
Float 208 [_Radius]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
// 60 instructions, 4 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 6 uint
// TEX 0 (0 load, 0 comp, 0 bias, 1 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcbaaiimjlicilbblkbbagliimncmacdmabaaaaaalmaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaacacaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmahaaaa
eaaaaaaaohabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaa
gcbaaaadbcbabaaaacaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaigbbbaaa
aeaaaaaadeaaaaajicaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaia
ibaaaaaaaaaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaddaaaaajbcaabaaaabaaaaaabkaabaia
ibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaah
ccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaj
ecaabaaaabaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaa
abaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
dbaaaaaidcaabaaaabaaaaaajgafbaaaaaaaaaaajgafbaiaebaaaaaaaaaaaaaa
abaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejmaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaddaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadbaaaaaibcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadeaaaaahecaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaiecaabaaaabaaaaaackaabaaa
abaaaaaackaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaadhaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaa
dkaabaaaaaaaaaaaabeaaaaaidpjccdoabeaaaaaaaaaaadpdcaaaaakicaabaaa
aaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaa
abeaaaaaiedefjlodcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaakeanmjdpaaaaaaaiecaabaaaaaaaaaaackaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeaabaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaaaaaaaaaabeaaaaaidpjkcdo
alaaaaafccaabaaaabaaaaaabkaabaaaacaaaaaaamaaaaafccaabaaaadaaaaaa
bkaabaaaacaaaaaaalaaaaafmcaabaaaaaaaaaaaagaebaaaaaaaaaaaamaaaaaf
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaidpjccdoapaaaaah
bcaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaaaaaaaaa
abeaaaaaidpjccdoejaaaaanpcaabaaaaaaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaaaaaaaaai
bcaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaajkjjjjdpdicaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaajkjjjjdpaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaialpbnaaaaahccaabaaaaaaaaaaa
dkbabaaaabaaaaaaabeaaaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaaakbabaaa
acaaaaaaabeaaaaaaaaaaaaaabaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaadiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaabnaaaaaiecaabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaabkbabaaaacaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
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

#LINE 87

      }
   }  
}