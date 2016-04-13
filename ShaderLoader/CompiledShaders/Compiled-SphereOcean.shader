Shader "EVE/Ocean" {
	Properties {
		_SurfaceColor ("Color Tint", Color) = (1,1,1,1)
		_SpecularColor ("Specular tint", Color) = (1,0,0,1)
		_SpecularPower ("Shininess", Float) = 10
		_MainTex ("Main (RGB)", 2D) = "white" {}
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		_DetailScale ("Detail Scale", Range(0,1000)) = 200
		_DetailDist ("Detail Distance", Range(0,1)) = 0.00875
		_MinLight ("Minimum Light", Range(0,1)) = .5
		_LightPower ("LightPower", Float) = 1.75
		_PlanetOpacity ("PlanetOpacity", Float) = 1
		_PlanetOrigin ("Planet Center", Vector) = (0,0,0,1)
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
		
		// shader program with errors was here
Program "err" { SubProgram { "!!error" } }

#LINE 125

	
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

#LINE 164


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

#LINE 225

        }
		
	} 

}