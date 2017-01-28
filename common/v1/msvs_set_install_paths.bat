REM
REM \author Zachary Wartell
REM
REM msvs_set_install_paths INSTALL_PARENT_DIR MSVS_BITS MSVS_VERSION 
REM
REM 

set INSTALL_PARENT_DIR=%1
set MSVS_BITS=%2
set MSVS_VERSION=%3

REM use string name convention used by MSVS macro $(Platform)
if "%MSVS_BITS%"=="64" (
    set MSVS_PLATFORM=x64
) else if "%MSVS_BITS%"=="32" (
    set MSVS_PLATFORM=win32
)

set INSTALL_DIR=%INSTALL_PARENT_DIR%\install\MSVS_%MSVS_VERSION%\%MSVS_PLATFORM%\
set INSTALL_BIN_DIR=%INSTALL_DIR%bin
set INSTALL_LIB_DIR=%INSTALL_DIR%lib
set INSTALL_INC_DIR=%INSTALL_DIR%include
