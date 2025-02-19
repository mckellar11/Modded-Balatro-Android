@echo off
setlocal enabledelayedexpansion

:: Get the current user's name and define paths
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set MODS_DIR=%BALATRO_DIR%\Mods
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua

:: Create necessary folders
mkdir "%NATIVEFS_DIR%" 2>nul
mkdir "%SMODS_DIR%" 2>nul

:: Create lovely.lua file
echo return { > "%LOVELY_FILE%"
echo   repo = "https://github.com/ethangreen-dev/lovely-injector", >> "%LOVELY_FILE%"
echo   version = "0.7.1", >> "%LOVELY_FILE%"
echo   mod_dir = "/data/data/com.unofficial.balatro/files/save/game/Mods", >> "%LOVELY_FILE%"
echo } >> "%LOVELY_FILE%"

:: Check for Flower Pot mod
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "flower.pot" >nul && set FP_DIR=%%D
)

if defined FP_DIR (
    set FP_LIBS=!FP_DIR!\libs
    if exist "!FP_LIBS!\json.lua" (
        copy /Y "!FP_LIBS!\json.lua" "%BALATRO_DIR%\FP_json.lua"
    )
    if exist "!FP_LIBS!\nativefs.lua" (
        copy /Y "!FP_LIBS!\nativefs.lua" "%BALATRO_DIR%\FP_nativefs.lua"
    )
)

:: Copy files from other mods
copy /Y "%USERPROFILE%\AppData\Roaming\Balatro\Mods\Talisman\nativefs.lua" "%NATIVEFS_DIR%" >nul 2>&1
copy /Y "%MODS_DIR%\smods-main\version.lua" "%SMODS_DIR%" >nul 2>&1
xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1

echo Done.
endlocal
exit /b
