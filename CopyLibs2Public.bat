@echo off
set OLDDIR=%CD%
cd /d %~dp0

:begin
IF "%1"=="" GOTO MissingParameters
IF "%1"=="x86" GOTO openhevc
IF "%1"=="x64" GOTO openhevc
IF "%1"=="all" GOTO openhevc
goto MissingParameters

:openhevc
set GIT=
for %%e in (%PATHEXT%) do (
  for %%X in (git%%e) do (
    if not defined GIT (
      set GIT=%%~$PATH:X
    )
  )
)

if not defined GIT goto git_not_found


IF EXIST ./openHEVC/ goto update_openhevc
git clone https://github.com/OpenHEVC/openHEVC.git
cd openHEVC
"%GIT%" checkout hevc_rext
cd ..
goto copy_openhevc

:update_openhevc
cd openHEVC
"%GIT%" checkout hevc_rext
"%GIT%" pull
cd ..
goto copy_openhevc

:git_not_found
echo "Git has not been found on your system, openhevc will not be enable"

:copy_openhevc
copy openHEVC\bin\ffmpeg_w32\libLibOpenHevcWrapper.dll lib\win32\debug\
copy openHEVC\bin\ffmpeg_w32\libLibOpenHevcWrapper.dll lib\win32\release\
copy openHEVC\bin\ffmpeg_w64\libLibOpenHevcWrapper.dll lib\x64\debug\
copy openHEVC\bin\ffmpeg_w64\libLibOpenHevcWrapper.dll lib\x64\release\

IF "%1"=="x64" GOTO win64
GOTO win32

:win32
echo Copying x86 extralibs
copy lib\win32\release\*eay* lib\win32\debug\
copy lib\win32\release\av* lib\win32\debug\
copy lib\win32\release\swscale* lib\win32\debug\
copy lib\win32\debug\*.lib ..\gpac_public\extra_lib\lib\win32\debug\
copy lib\win32\release\*.lib ..\gpac_public\extra_lib\lib\win32\release\
copy lib\win32\debug\*.dll ..\gpac_public\bin\win32\debug\
copy lib\win32\release\*.dll ..\gpac_public\bin\win32\release\
copy lib\win32\release\*.manifest ..\gpac_public\bin\win32\release\
copy lib\win32\debug\*.plg ..\gpac_public\bin\win32\debug\
copy lib\win32\release\*.plg ..\gpac_public\bin\win32\release\
if exist xulrunner-7.0.1.en-US.win32.sdk.zip goto XULSDK_copy
wget --no-check-certificate https://ftp.mozilla.org/pub/mozilla.org/mozilla.org/xulrunner/releases/7.0.1/sdk/xulrunner-7.0.1.en-US.win32.sdk.zip
unzip -n xulrunner-7.0.1.en-US.win32.sdk.zip
:XULSDK_copy
xcopy /i /e /q /y xulrunner-sdk ..\gpac_public\extra_lib\include\xulrunner-sdk\
:DekTec_copy
unzip -n dektec_dtapi_5.2.zip
if exist SDL-devel-1.2.15-VC.zip goto SDL_copy
wget http://www.libsdl.org/release/SDL-devel-1.2.15-VC.zip
unzip SDL-devel-1.2.15-VC.zip
:SDL_copy
copy SDL-1.2.15\include\ ..\gpac_public\extra_lib\include\SDL\
copy SDL-1.2.15\lib\x86\*.lib ..\gpac_public\extra_lib\lib\win32\debug\
copy SDL-1.2.15\lib\x86\*.lib ..\gpac_public\extra_lib\lib\win32\release\
copy SDL-1.2.15\lib\x86\*.dll ..\gpac_public\bin\win32\debug\
copy SDL-1.2.15\lib\x86\*.dll ..\gpac_public\bin\win32\release\
IF "%1"=="all" GOTO win64
GOTO done

:win64
echo Copying x64 extralibs
copy lib\x64\release\*eay* lib\x64\debug\
copy lib\x64\release\av* lib\x64\debug\
copy lib\x64\release\swscale* lib\x64\debug\
copy lib\x64\debug\*.lib ..\gpac_public\extra_lib\lib\x64\debug\
copy lib\x64\release\*.lib ..\gpac_public\extra_lib\lib\x64\release\
copy lib\x64\debug\*.dll ..\gpac_public\bin\x64\debug\
copy lib\x64\release\*.dll ..\gpac_public\bin\x64\release\
copy lib\x64\release\*.manifest ..\gpac_public\bin\x64\release\

if exist xulrunner-7.0.1.en-US.win32.sdk.zip goto XULSDK_copy
wget --no-check-certificate https://ftp.mozilla.org/pub/mozilla.org/mozilla.org/xulrunner/releases/7.0.1/sdk/xulrunner-7.0.1.en-US.win32.sdk.zip
unzip -n xulrunner-7.0.1.en-US.win32.sdk.zip
:XULSDK_copy
xcopy /i /e /q /y xulrunner-sdk ..\gpac_public\extra_lib\include\xulrunner-sdk\
:DekTec_copy
unzip -n dektec_dtapi_5.2.zip
if exist SDL-devel-1.2.15-VC.zip goto SDL_copy
wget http://www.libsdl.org/release/SDL-devel-1.2.15-VC.zip
unzip SDL-devel-1.2.15-VC.zip
:SDL_copy
copy SDL-1.2.15\include\ ..\gpac_public\extra_lib\include\SDL\
copy SDL-1.2.15\lib\x64\*.lib ..\gpac_public\extra_lib\lib\x64\debug\
copy SDL-1.2.15\lib\x64\*.lib ..\gpac_public\extra_lib\lib\x64\release\
copy SDL-1.2.15\lib\x64\*.dll ..\gpac_public\bin\x64\debug\
copy SDL-1.2.15\lib\x64\*.dll ..\gpac_public\bin\x64\release\
GOTO done

:MissingParameters
Echo You must specified target architecture : either x86, x64 or all

:done
cd /d %OLDDIR%