Shader "!Debug/Vertex color" {
SubShader {
Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Fog { Mode Global}
	AlphaTest Greater 0
	ColorMask RGB
	Cull Off Lighting On ZWrite Off
    Pass {
        Fog { Mode Off }
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 31 to 31
//   d3d9 - ALU: 32 to 32
//   d3d11 - ALU: 10 to 10, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 10 to 10, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 5 [_Time]
"!!ARBvp1.0
# 31 ALU
PARAM c[10] = { { 1, 0.25, 0.15915491, -1 },
		state.matrix.mvp,
		program.local[5],
		{ 0, 0.5, 1, 2.5 },
		{ 24.980801, -24.980801, -60.145809, 60.145809 },
		{ 85.453789, -85.453789, -64.939346, 64.939346 },
		{ 19.73921, -19.73921, -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
FRC R3.xy, vertex.texcoord[0];
MOV R0.x, c[0].y;
MAD R0.x, R0, c[5].z, R3;
MUL R0.x, R0, c[0].z;
FRC R0.w, R0.x;
ADD R0.xyz, -R0.w, c[6];
MUL R0.xyz, R0, R0;
MAD R1.xyz, R0, c[7].xyxw, c[7].zwzw;
MAD R1.xyz, R1, R0, c[8].xyxw;
MAD R1.xyz, R1, R0, c[8].zwzw;
MAD R1.xyz, R1, R0, c[9].xyxw;
MOV R3.zw, c[0].x;
MAD R1.xyz, R1, R0, c[0].wxww;
SLT R2.x, R0.w, c[0].y;
SGE R2.yz, R0.w, c[9].xzww;
MOV R0.xz, R2;
DP3 R0.y, R2, c[0].wxww;
DP3 R0.x, R1, -R0;
ADD R0.x, R0, c[0];
MUL R0.y, R0.x, vertex.normal.z;
MUL R0.w, R0.x, vertex.normal.y;
MAD R0.z, R0.y, c[6].w, vertex.position;
MAD R0.y, R0.w, c[6].w, vertex.position;
MUL R0.x, R0, vertex.normal;
MOV R0.w, vertex.position;
MAD R0.x, R0, c[6].w, vertex.position;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.color, R3;
END
# 31 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Time]
"vs_2_0
; 32 ALU
def c5, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c6, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c7, 0.25000000, 0.15915491, 0.50000000, 2.50000000
def c8, 6.28318501, -3.14159298, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
frc r0.xy, v2
mov r0.z, c4
mad r0.z, c7.x, r0, r0.x
mad r0.z, r0, c7.y, c7
frc r0.z, r0
mad r0.z, r0, c8.x, c8.y
sincos r1.xy, r0.z, c6.xyzw, c5.xyzw
add r0.z, r1.x, c5
mul r0.w, r0.z, v1.z
mul r1.x, r0.z, v1.y
mad r1.z, r0.w, c7.w, v0
mad r1.y, r1.x, c7.w, v0
mul r0.z, r0, v1.x
mad r1.x, r0.z, c7.w, v0
mov r1.w, v0
mov r0.zw, c5.z
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
mov oD0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjailmplifgpdecickehfdgmkclgainbfabaaaaaaaiadaaaaadaaaaaa
cmaaaaaalmaaaaaabaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaafaepfdej
feejepeoaaedepemepfcaaeoepfcenebemaafeeffiedepepfceeaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklfdeieefcpaabaaaaeaaaabaahmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
giaaaaacacaaaaaabkaaaaafdcaabaaaaaaaaaaaegbabaaaadaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaaaaaaaaaaaaaaaaaabeaaaaaaaaaiadoakaabaaa
aaaaaaaadgaaaaafdccabaaaabaaaaaaegaabaaaaaaaaaaaenaaaaagaanaaaaa
bcaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaacaeadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaabaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaaimccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaiadpdoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec4 xlv_COLOR;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 vert_2;
  mediump vec2 c_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract(_glesMultiTexCoord0.xy);
  c_3 = tmpvar_5;
  vert_2.w = _glesVertex.w;
  vert_2.x = (_glesVertex.x + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.x));
  vert_2.y = (_glesVertex.y + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.y));
  vert_2.z = (_glesVertex.z + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.z));
  tmpvar_4.xy = c_3;
  tmpvar_4.z = 1.0;
  tmpvar_4.w = 1.0;
  gl_Position = (glstate_matrix_mvp * vert_2);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec4 xlv_COLOR;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = normalize(_glesNormal);
  highp vec4 vert_2;
  mediump vec2 c_3;
  lowp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract(_glesMultiTexCoord0.xy);
  c_3 = tmpvar_5;
  vert_2.w = _glesVertex.w;
  vert_2.x = (_glesVertex.x + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.x));
  vert_2.y = (_glesVertex.y + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.y));
  vert_2.z = (_glesVertex.z + ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c_3.x)))) * tmpvar_1.z));
  tmpvar_4.xy = c_3;
  tmpvar_4.z = 1.0;
  tmpvar_4.w = 1.0;
  gl_Position = (glstate_matrix_mvp * vert_2);
  xlv_COLOR = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Time]
"agal_vs
c5 -0.020833 -0.125 1.0 0.5
c6 -0.000002 -0.000022 0.002604 0.00026
c7 0.25 0.159155 0.5 2.5
c8 6.283185 -3.141593 0.0 0.0
[bc]
aiaaaaaaaaaaadacadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa frc r0.xy, a3
aaaaaaaaaaaaaeacaeaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.z, c4
adaaaaaaabaaaeacahaaaaaaabaaaaaaaaaaaakkacaaaaaa mul r1.z, c7.x, r0.z
abaaaaaaaaaaaeacabaaaakkacaaaaaaaaaaaaaaacaaaaaa add r0.z, r1.z, r0.x
adaaaaaaaaaaaeacaaaaaakkacaaaaaaahaaaaffabaaaaaa mul r0.z, r0.z, c7.y
abaaaaaaaaaaaeacaaaaaakkacaaaaaaahaaaaoeabaaaaaa add r0.z, r0.z, c7
aiaaaaaaaaaaaeacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa frc r0.z, r0.z
adaaaaaaaaaaaeacaaaaaakkacaaaaaaaiaaaaaaabaaaaaa mul r0.z, r0.z, c8.x
abaaaaaaaaaaaeacaaaaaakkacaaaaaaaiaaaaffabaaaaaa add r0.z, r0.z, c8.y
apaaaaaaabaaabacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa sin r1.x, r0.z
baaaaaaaabaaacacaaaaaakkacaaaaaaaaaaaaaaaaaaaaaa cos r1.y, r0.z
abaaaaaaaaaaaeacabaaaaaaacaaaaaaafaaaaoeabaaaaaa add r0.z, r1.x, c5
adaaaaaaaaaaaiacaaaaaakkacaaaaaaabaaaakkaaaaaaaa mul r0.w, r0.z, a1.z
adaaaaaaabaaabacaaaaaakkacaaaaaaabaaaaffaaaaaaaa mul r1.x, r0.z, a1.y
adaaaaaaabaaaeacaaaaaappacaaaaaaahaaaappabaaaaaa mul r1.z, r0.w, c7.w
abaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaoeaaaaaaaa add r1.z, r1.z, a0
adaaaaaaabaaacacabaaaaaaacaaaaaaahaaaappabaaaaaa mul r1.y, r1.x, c7.w
abaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaoeaaaaaaaa add r1.y, r1.y, a0
adaaaaaaaaaaaeacaaaaaakkacaaaaaaabaaaaaaaaaaaaaa mul r0.z, r0.z, a1.x
adaaaaaaabaaabacaaaaaakkacaaaaaaahaaaappabaaaaaa mul r1.x, r0.z, c7.w
abaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaoeaaaaaaaa add r1.x, r1.x, a0
aaaaaaaaabaaaiacaaaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r1.w, a0
aaaaaaaaaaaaamacafaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, c5.z
bdaaaaaaaaaaaiadabaaaaoeacaaaaaaadaaaaoeabaaaaaa dp4 o0.w, r1, c3
bdaaaaaaaaaaaeadabaaaaoeacaaaaaaacaaaaoeabaaaaaa dp4 o0.z, r1, c2
bdaaaaaaaaaaacadabaaaaoeacaaaaaaabaaaaoeabaaaaaa dp4 o0.y, r1, c1
bdaaaaaaaaaaabadabaaaaoeacaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, r1, c0
aaaaaaaaahaaapaeaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov v7, r0
"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerCamera" 0
BindCB "UnityPerDraw" 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednmaciojbhdpijcbeapdhdjgphikjbbacabaaaaaabiafaaaaaeaaaaaa
daaaaaaadmacaaaadeaeaaaameaeaaaaebgpgodjaeacaaaaaeacaaaaaaacpopp
meabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiadoidpjccdoaaaaaadpaaaaiadpfbaaaaafahaaapkanlapmjea
nlapejmaaaaacaeaaaaaaaaafbaaaaafaiaaapkaabannalfgballglhklkkckdl
ijiiiidjfbaaaaafajaaapkaklkkkklmaaaaaaloaaaaiadpaaaaaadpbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
bdaaaaacaaaaadiaadaaoejaabaaaaacabaaabiaagaaaakaaeaaaaaeaaaaaeia
abaakkkaabaaaaiaaaaaaaiaabaaaaacaaaaadoaaaaaoeiaaeaaaaaeaaaaabia
aaaakkiaagaaffkaagaakkkabdaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaaabia
aaaaaaiaahaaaakaahaaffkacfaaaaaeabaaabiaaaaaaaiaaiaaoekaajaaoeka
acaaaaadaaaaabiaabaaaaiaagaappkaafaaaaadaaaaabiaaaaaaaiaahaakkka
abaaaaacabaaahiaaaaaoejaaeaaaaaeaaaaahiaaaaaaaiaacaaoejaabaaoeia
afaaaaadabaaapiaaaaaffiaadaaoekaaeaaaaaeabaaapiaacaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoaagaappkappppaaaafdeieefc
paabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacacaaaaaabkaaaaafdcaabaaaaaaaaaaa
egbabaaaadaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaaaaaaaaaaaaaaaaa
abeaaaaaaaaaiadoakaabaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegaabaaa
aaaaaaaaenaaaaagaanaaaaabcaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaacaeadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaabaaaaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaimccabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpdoaaaaabejfdeheoiiaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaahoaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaafaepfdejfeejepeoaaedepemepfcaaeoepfcenebemaafeeffiedepep
fceeaaklepfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl"
}

SubProgram "gles3 " {
Keywords { }
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

#line 59
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
};
#line 51
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
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
#line 65
#line 65
v2f vert( in appdata v ) {
    v2f o;
    mediump vec2 c = fract(v.texcoord.xy);
    #line 69
    highp vec4 vert = v.vertex;
    vert.x += ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c.x)))) * v.normal.x);
    vert.y += ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c.x)))) * v.normal.y);
    vert.z += ((2.5 * (1.0 + cos(((0.25 * _Time.z) + c.x)))) * v.normal.z);
    #line 73
    o.pos = (glstate_matrix_mvp * vert);
    o.color.xy = c.xy;
    o.color.z = 1.0;
    o.color.w = 1.0;
    #line 77
    return o;
}
out lowp vec4 xlv_COLOR;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 59
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
};
#line 51
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
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
#line 65
#line 79
lowp vec4 frag( in v2f i ) {
    #line 81
    return i.color;
}
in lowp vec4 xlv_COLOR;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 1 to 1, TEX: 0 to 0
//   d3d9 - ALU: 1 to 1
//   d3d11 - ALU: 0 to 0, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 0 to 0, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!ARBfp1.0
# 1 ALU, 0 TEX
MOV result.color, fragment.color.primary;
END
# 1 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
"ps_2_0
; 1 ALU
dcl v0
mov_pp oC0, v0
"
}

SubProgram "d3d11 " {
Keywords { }
// 2 instructions, 0 temp regs, 0 temp arrays:
// ALU 0 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfjdoiaijdeijhjdpnpibjbpjbcgfffpfabaaaaaapeaaaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegbobaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "flash " {
Keywords { }
"agal_ps
[bc]
aaaaaaaaaaaaapadahaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov o0, v7
"
}

SubProgram "d3d11_9x " {
Keywords { }
// 2 instructions, 0 temp regs, 0 temp arrays:
// ALU 0 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedmdmomhldiedflkcimhkfbplmajbggmfnabaaaaaaeeabaaaaaeaaaaaa
daaaaaaahmaaaaaalmaaaaaabaabaaaaebgpgodjeeaaaaaaeeaaaaaaaaacpppp
caaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
bpaaaaacaaaaaaiaaaaacplaabaaaaacaaaicpiaaaaaoelappppaaaafdeieefc
diaaaaaaeaaaaaaaaoaaaaaagcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaaklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 44

    }
}
}