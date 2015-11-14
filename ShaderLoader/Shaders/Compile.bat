@echo off

if not exist "..\CompiledShaders" mkdir ..\CompiledShaders

IF %1.==. GOTO No1
CgBatch %1 . "%CGINC%" ..\CompiledShaders\Compiled-%1

GOTO End


:No1
  for %%f in (*.shader) do (
	CgBatch %%f . "%CGINC%" ..\CompiledShaders\Compiled-%%f
)
GOTO End

:End