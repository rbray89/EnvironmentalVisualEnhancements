Shader "EVE/PlanetShadow" {
	Properties{
		_PlanetOrigin("Sphere Center", Vector) = (0,0,0,1)
		_SunDir("Sunlight direction", Vector) = (0,0,0,1)
		_PlanetRadius("Planet Radius", Float) = 1
	}
	SubShader{
		Pass {
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Program "vp" {
// Vertex combos: 1
//   d3d9 - ALU: 15 to 15
//   d3d11 - ALU: 13 to 13, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL
#ifdef VERTEX
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform mat4 _Projector;
uniform vec4 _SunDir;
uniform mat4 _Object2World;

void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = gl_Normal;
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_Object2World * tmpvar_1).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Projector * gl_Vertex);
  xlv_TEXCOORD1 = -(dot (_SunDir, tmpvar_2));
}


#endif
#ifdef FRAGMENT
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  color_1.xyz = vec3(1.0, 0.0, 1.0);
  color_1.w = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0)));
  gl_FragData[0] = color_1;
}


#endif
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_SunDir]
Matrix 8 [_Projector]
"vs_3_0
; 15 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c13, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c13.x
mov r1.xyz, v1
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 r0.x, r0, c12
mov o2.x, -r0
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
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 320 // 320 used size, 13 vars
Vector 224 [_SunDir] 4
Matrix 256 [_Projector] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 14 instructions, 1 temp regs, 0 temp arrays:
// ALU 13 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgjjamnkdllbdggdcmibblmhdfafheejcabaaaaaaeaadaaaaadaaaaaa
cmaaaaaahmaaaaaaomaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaabaoaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcemacaaaaeaaaabaajdaaaaaafjaaaaae
egiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaapaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadbccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaabcaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaabaaaaaaegiocaaaaaaaaaaa
bdaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaabaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaaibcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaaegacbaaa
aaaaaaaadgaaaaagbccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _SunDir;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_Object2World * tmpvar_1).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = -(dot (_SunDir, tmpvar_2));
}



#endif
#ifdef FRAGMENT

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0)));
  shadowCheck_3 = tmpvar_4;
  color_2.xyz = vec3(1.0, 0.0, 1.0);
  color_2.w = shadowCheck_3;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _Projector;
uniform highp vec4 _SunDir;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = normalize(_glesNormal);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_Object2World * tmpvar_1).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Projector * _glesVertex);
  xlv_TEXCOORD1 = -(dot (_SunDir, tmpvar_2));
}



#endif
#ifdef FRAGMENT

varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  mediump float shadowCheck_3;
  highp float tmpvar_4;
  tmpvar_4 = (float((xlv_TEXCOORD0.w >= 0.0)) * float((xlv_TEXCOORD1 >= 0.0)));
  shadowCheck_3 = tmpvar_4;
  color_2.xyz = vec3(1.0, 0.0, 1.0);
  color_2.w = shadowCheck_3;
  tmpvar_1 = color_2;
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 466
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float nDotL;
};
#line 460
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 409
#line 413
#line 429
#line 450
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 454
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp vec4 _SunDir;
uniform highp float _PlanetRadius;
#line 458
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 473
#line 481
#line 473
v2f vert( in appdata_t v ) {
    v2f o;
    o.posProj = (_Projector * v.vertex);
    #line 477
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.nDotL = (-dot( _SunDir, vec4( (_Object2World * vec4( v.normal, 0.0)).xyz, 0.0)));
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_t xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.posProj);
    xlv_TEXCOORD1 = float(xl_retval.nDotL);
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
#line 466
struct v2f {
    highp vec4 pos;
    highp vec4 posProj;
    highp float nDotL;
};
#line 460
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp mat4 _MainRotation;
uniform highp mat4 _DetailRotation;
#line 393
#line 409
#line 413
#line 429
#line 450
uniform sampler2D _MainTex;
uniform highp vec4 _MainOffset;
uniform sampler2D _DetailTex;
uniform lowp vec4 _DetailOffset;
#line 454
uniform highp float _DetailScale;
uniform highp float _DetailDist;
uniform highp vec4 _SunDir;
uniform highp float _PlanetRadius;
#line 458
uniform highp vec3 _PlanetOrigin;
uniform highp mat4 _Projector;
#line 473
#line 481
#line 481
lowp vec4 frag( in v2f IN ) {
    mediump float shadowCheck = (step( 0.0, IN.posProj.w) * step( 0.0, IN.nDotL));
    mediump vec4 color;
    #line 485
    color.w = xll_saturate_f((abs(IN.posProj.x) + abs(IN.posProj.y)));
    color.xyz = vec3( 1.0, 0.0, 1.0);
    color.w = shadowCheck;
    return color;
}
in highp vec4 xlv_TEXCOORD0;
in highp float xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.posProj = vec4(xlv_TEXCOORD0);
    xlt_IN.nDotL = float(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   d3d9 - ALU: 4 to 4
//   d3d11 - ALU: 4 to 4, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!GLSL"
}

SubProgram "d3d9 " {
Keywords { }
"ps_3_0
; 4 ALU
def c0, 1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.x
cmp r0.y, v1.x, c0.x, c0
cmp r0.x, v0.w, c0, c0.y
mov_pp oC0.xyz, c0.xyxw
mul oC0.w, r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { }
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 1 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedmgbejbbcebhomaijkgcekkdkjbmmoehkabaaaaaakmabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneaaaaaaeaaaaaaadfaaaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaadbcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaabnaaaaahbcaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaaaaaaaabnaaaaahccaabaaaaaaaaaaaakbabaaaacaaaaaaabeaaaaa
aaaaaaaaabaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaadoaaaaab"
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

#LINE 61

		}
	}
}