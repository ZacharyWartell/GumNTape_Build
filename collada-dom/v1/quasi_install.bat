REM \author Zachary Wartell <zwartell@uncc.edu>
REM
REM quasi_install.bat %PLATFORM% %CONFIGURAION% %TARGET_NAME% %TARGET_DIR% %PLATFORM_TOOLS_SET% %INSTALL_INC_PATH_SUFFIX% %PUBLIC_INC_DIR%
REM
REM Arguements are required and are the correspondingly named MSVS macros
REM
REM %PLATFORM% 		= $(Platform)
REM %CONFIGURATION% 	= $(Configuration)
REM %TARGET_NAME% 	= $(TargetName)
REM %MSVS_VERSION%	= [2010 | 2015] 
REM %INSTALL_INC_PATH_SUFFIX% = path suffix to append to \include installation directory

set PLATFORM=%1
set CONFIGURATION=%2
set TARGET_NAME=%3
set TARGET_DIR=%4
set PLATFORM_TOOLS_SET=%5
set INSTALL_INC_PATH_SUFFIX=%6
set PUBLIC_INC_DIR=%7

set DEBUG=0
echo --------------------------
echo Running "quasi_install.bat"

if %DEBUG% GEQ 1 (
    echo %*
)
REM cd
REM exit /b


if "%PLATFORM_TOOLS_SET%" == "v100" (
    set MSVS_VERSION=2010
) else if "%PLATFORM_TOOLS_SET%" == "v140" (
    set MSVS_VERSION=2015
)

set INSTALL_DIR=..\..\..\..\install\MSVS_%MSVS_VERSION%\%PLATFORM%\
set INSTALL_BIN_DIR=%INSTALL_DIR%bin
set INSTALL_LIB_DIR=%INSTALL_DIR%lib
set INSTALL_INC_DIR=%INSTALL_DIR%include\%INSTALL_INC_PATH_SUFFIX%



if %DEBUG% GEQ 1 (
	echo CD: %CD%
	echo INSTALL_BIN_DIR: %INSTALL_BIN_DIR%
	if %DEBUG% GEQ 2 dir %INSTALL_BIN_DIR%
	echo INSTALL_LIB_DIR: %INSTALL_LIB_DIR%
	if %DEBUG% GEQ 2 dir %INSTALL_LIB_DIR%
	echo INSTALL_INC_DIR: %INSTALL_INC_DIR%
	if %DEBUG% GEQ 2 dir %PUBLIC_INC_DIR%
	echo PUBLIC_INC_DIR: %PUBLIC_INC_DIR%
	if %DEBUG% GEQ 2 dir %INSTALL_INC_DIR%
	if %DEBUG% GEQ 2 (
	    echo TARGET_DIR:
	    dir %TARGET_DIR%
	)
)

REM adapt to MSVS defaults
REM \todo this part is probably deprecated and can be deleted...
if %PLATFORM% == Win32 (
	set OUTPUT_SUFFIX_DIR=%CONFIGURATION%
) else (
	set OUTPUT_SUFFIX_DIR=%PLATFORM%\%CONFIGURATION%
)

REM
REM debugging stuff
REM

if %DEBUG% == 1 (
	cd
	echo OUTPUT_SUFFIX_DIR: %OUTPUT_SUFFIX_DIR%

	echo HERE
	dir "%OUTPUT_SUFFIX_DIR%"
	dir "Debug"

	echo UP
	dir "..\%OUTPUT_SUFFIX_DIR%"
)

REM
REM install .dll 
REM

echo.%TARGET_NAME% | findstr /C:"dll" 1>nul
if errorlevel 1 (
    xcopy /Y /D "%TARGET_DIR%*.dll" "%INSTALL_BIN_DIR%\"
    xcopy /Y /D "%TARGET_DIR%*.pdb" "%INSTALL_LIB_DIR%\"
) 

REM
REM install .lib
REM

xcopy /Y /D "%TARGET_DIR%*.lib" "%INSTALL_LIB_DIR%\"

REM
REM install .h
REM

IF NOT EXIST "%INSTALL_INC_DIR%" mkdir "%INSTALL_INC_DIR%"
xcopy /E /Y /D "%PUBLIC_INC_DIR%\*" "%INSTALL_INC_DIR%\" 

exit /b
