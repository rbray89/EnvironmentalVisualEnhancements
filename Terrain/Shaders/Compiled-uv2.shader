Shader "!Debug/UV 2" {
SubShader {
    Pass {
        Fog { Mode Off }
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 6 to 6
//   d3d9 - ALU: 6 to 6
//   d3d11 - ALU: 4 to 4, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 4 to 4, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { { 0 },
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[1];
MOV result.texcoord[0].zw, c[0].x;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
def c4, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord1 v1
mov oT0.xy, v1
mov oT0.zw, c4.x
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerDraw" 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedacgmhipikhhgeaigndpfhlglmcknbhmbabaaaaaaaeacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcceabaaaa
eaaaabaaejaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dgaaaaaimccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = fract(xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  bvec4 tmpvar_3;
  tmpvar_3 = bvec4((clamp (xlv_TEXCOORD0, 0.0, 1.0) - xlv_TEXCOORD0));
  bool tmpvar_4;
  tmpvar_4 = any(tmpvar_3);
  if (tmpvar_4) {
    c_1.z = 0.5;
  };
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = _glesMultiTexCoord1.xy;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 c_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = fract(xlv_TEXCOORD0);
  c_1 = tmpvar_2;
  bvec4 tmpvar_3;
  tmpvar_3 = bvec4((clamp (xlv_TEXCOORD0, 0.0, 1.0) - xlv_TEXCOORD0));
  bool tmpvar_4;
  tmpvar_4 = any(tmpvar_3);
  if (tmpvar_4) {
    c_1.z = 0.5;
  };
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
"agal_vs
c4 0.0 0.0 0.0 0.0
[bc]
aaaaaaaaaaaaadaeaeaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v0.xy, a4
aaaaaaaaaaaaamaeaeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c4.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerDraw" 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednlphchhiejdfbhdfibmjajomcmcacgjhabaaaaaapiacaaaaaeaaaaaa
daaaaaaacaabaaaaemacaaaakaacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpopp
leaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafafaaapkaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
afaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaafaaaaadaaaaapoaabaaaejaafaafakappppaaaa
fdeieefcceabaaaaeaaaabaaejaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaa
egbabaaaabaaaaaadgaaaaaimccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

#line 57
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
};
#line 51
struct appdata {
    highp vec4 vertex;
    highp vec4 texcoord1;
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
#line 63
#line 63
v2f vert( in appdata v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 67
    o.uv = vec4( v.texcoord1.xy, 0.0, 0.0);
    return o;
}
out highp vec4 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
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
#line 57
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
};
#line 51
struct appdata {
    highp vec4 vertex;
    highp vec4 texcoord1;
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
#line 63
#line 70
mediump vec4 frag( in v2f i ) {
    #line 72
    mediump vec4 c = fract(i.uv);
    if (any(bvec4((xll_saturate_vf4(i.uv) - i.uv)))){
        c.z = 0.5;
    }
    return c;
}
in highp vec4 xlv_TEXCOORD0;
void main() {
    mediump vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 10 to 10, TEX: 0 to 0
//   d3d9 - ALU: 10 to 10
//   d3d11 - ALU: 4 to 4, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 4 to 4, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!ARBfp1.0
# 10 ALU, 0 TEX
PARAM c[1] = { { 1, 0, 0.5 } };
TEMP R0;
TEMP R1;
MOV_SAT R0, fragment.texcoord[0];
ADD R0, R0, -fragment.texcoord[0];
ABS R0, R0;
CMP R1, -R0, c[0].x, c[0].y;
ADD_SAT R0.x, R1, R1.y;
ADD_SAT R1.x, R0, R1.z;
FRC R0, fragment.texcoord[0];
ADD_SAT R1.x, R1, R1.w;
CMP result.color.z, -R1.x, c[0], R0;
MOV result.color.xyw, R0;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
"ps_2_0
; 10 ALU
def c0, 0.00000000, 1.00000000, 0.50000000, 0
dcl t0
mov_sat r0, t0
add r0, r0, -t0
abs r0, r0
cmp r0, -r0, c0.x, c0.y
add_pp_sat r0.x, r0, r0.y
add_pp_sat r0.x, r0, r0.z
frc r1, t0
add_pp_sat r0.x, r0, r0.w
cmp_pp r1.z, -r0.x, r1, c0
mov_pp oC0, r1
"
}

SubProgram "d3d11 " {
Keywords { }
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjklhhkjemhobbhpjoapbcpiejgooopbiabaaaaaakeabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeaaaaaa
eaaaaaaadjaaaaaagcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadgcaaaafpcaabaaaaaaaaaaaegbobaaaabaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaiaebaaaaaaabaaaaaabbaaaaah
bcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadjaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaaaaafpcaabaaaabaaaaaa
egbobaaaabaaaaaadhaaaaajeccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpckaabaaaabaaaaaadgaaaaaflccabaaaaaaaaaaaegambaaaabaaaaaa
doaaaaab"
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
c0 0.0 1.0 0.5 0.0
[bc]
aaaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0, v0
bgaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa sat r0, r0
acaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaoeaeaaaaaa sub r0, r0, v0
beaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa abs r0, r0
bfaaaaaaabaaapacaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa neg r1, r0
ckaaaaaaabaaapacabaaaaoeacaaaaaaaaaaaaaaabaaaaaa slt r1, r1, c0.x
aaaaaaaaacaaapacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2, c0
aaaaaaaaadaaapacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r3, c0
acaaaaaaacaaapacacaaaaffacaaaaaaadaaaaaaacaaaaaa sub r2, r2.y, r3.x
adaaaaaaaaaaapacacaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r2, r1
abaaaaaaaaaaapacaaaaaaoeacaaaaaaaaaaaaaaabaaaaaa add r0, r0, c0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaffacaaaaaa add r0.x, r0.x, r0.y
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaakkacaaaaaa add r0.x, r0.x, r0.z
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
aiaaaaaaabaaapacaaaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa frc r1, v0
abaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa add r0.x, r0.x, r0.w
bgaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa sat r0.x, r0.x
bfaaaaaaacaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r2.x, r0.x
ckaaaaaaacaaaeacacaaaaaaacaaaaaaaaaaaaaaabaaaaaa slt r2.z, r2.x, c0.x
acaaaaaaaaaaaeacaaaaaaoeabaaaaaaabaaaakkacaaaaaa sub r0.z, c0, r1.z
adaaaaaaaaaaaeacaaaaaakkacaaaaaaacaaaakkacaaaaaa mul r0.z, r0.z, r2.z
abaaaaaaabaaaeacaaaaaakkacaaaaaaabaaaakkacaaaaaa add r1.z, r0.z, r1.z
aaaaaaaaaaaaapadabaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r1
"
}

SubProgram "d3d11_9x " {
Keywords { }
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedcffimgijkfffmcnabnppidkbbloboodhabaaaaaafiacaaaaaeaaaaaa
daaaaaaaoaaaaaaammabaaaaceacaaaaebgpgodjkiaaaaaakiaaaaaaaaacpppp
ieaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplaabaaaaacaaaabpiaaaaaoelaacaaaaadaaaaapiaaaaaoeiaaaaaoelb
ajaaaaadaaaaabiaaaaaoeiaaaaaoeiabdaaaaacabaacpiaaaaaoelafiaaaaae
abaaceiaaaaaaaibabaakkiaaaaaaakaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefcoeaaaaaaeaaaaaaadjaaaaaagcbaaaadpcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadgcaaaafpcaabaaaaaaaaaaaegbobaaa
abaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaiaebaaaaaa
abaaaaaabbaaaaahbcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
djaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaaaaaf
pcaabaaaabaaaaaaegbobaaaabaaaaaadhaaaaajeccabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpckaabaaaabaaaaaadgaaaaaflccabaaaaaaaaaaa
egambaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 31

    }
}
}