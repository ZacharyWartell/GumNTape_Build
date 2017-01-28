echo off
REM \author Zachary Wartell <zwartell@uncc.edu>
REM
REM msvs_tools_setup MSVS_VERSION MSVS_BITS
REM 
REM See USAGE

REM set DEBUG_EXIT1=1
REM set DEBUG_EXIT2=1

REM 
REM USAGE
REM
if "%1"=="/?" (
	echo Call MSVS 'vcvarsall.bat' script to setup command-line MSVS tools
	echo. 
	echo USAGE:
	echo. 
	echo msvs_tools_setup.bat MSVS_BITS MSVS_VERSION
	echo. 
	echo MSVS_BITS = 32 or 64 
	echo      determines whether compilation result is for 32 or 64 architecture
	echo. 
	echo MSVS_VERSION = 2010 or 2015
	echo      determines what version of MSVS is used to compile boost. 
	echo. 
	exit /b
)

set MSVS_BITS=%1
set MSVS_VERSION=%2

REM Follow MSVS convention for directory name (Platform MSVS macro)
if "%MSVS_BITS%"=="64" (
	set INSTALL_DIR=%TPL_DIR%\install\MSVS_%MSVS_VERSION%\x64\
	set MSVS_ARCH=amd64
) else if "%MSVS_BITS%"=="32" (
	set INSTALL_DIR=%TPL_DIR%\install\MSVS_%MSVS_VERSION%\win32\
	set MSVS_ARCH=x86
) else (
	echo MSVS_BITS %MSVS_BITS% is illegal value!
	echo For help type: %0 /? 
	exit /b
)

set INSTALL_LIB_DIR=%INSTALL_DIR%lib\

if "%MSVS_VERSION%"=="2010" (
    REM Setup MSVS 2010 Compiler Settings
    pushd "%VS100COMNTOOLS%\..\..\VC"
    call vcvarsall.bat %MSVS_ARCH% 
    popd
) ELSE IF "%MSVS_VERSION%"=="2015" (
    REM Setup MSVS 2015 Compiler Settings
    pushd "%VS140COMNTOOLS%\..\..\VC"
    call vcvarsall.bat %MSVS_ARCH%  
    popd
) ELSE (
    echo MSVS_VERSION %MSVS_VERSION% not yet supported by this script...
    exit /b
)
