@echo off
set OLDDIR=%CD%
cd /d %~dp0
copy "lib\smartphone 2003 (armv4)\release\av*" "lib\smartphone 2003 (armv4)\debug\"
copy "lib\smartphone 2003 (armv4)\release\swscale*" "lib\smartphone 2003 (armv4)\debug\"
copy "lib\smartphone 2003 (armv4)\debug\*.lib" "..\gpac_public\extra_lib\lib\smartphone 2003 (armv4)\debug\"
copy "lib\smartphone 2003 (armv4)\release\*.lib" "..\gpac_public\extra_lib\lib\smartphone 2003 (armv4)\release\"
copy "lib\smartphone 2003 (armv4)\debug\*.dll" "..\gpac_public\bin\smartphone 2003 (armv4)\debug\"
copy "lib\smartphone 2003 (armv4)\release\*.dll" "..\gpac_public\bin\smartphone 2003 (armv4)\release\"
copy "lib\smartphone 2003 (armv4)\debug\*.plg" "..\gpac_public\bin\smartphone 2003 (armv4)\debug\"
copy "lib\smartphone 2003 (armv4)\release\*.plg" "..\gpac_public\bin\smartphone 2003 (armv4)\release\"
cd /d %OLDDIR%
