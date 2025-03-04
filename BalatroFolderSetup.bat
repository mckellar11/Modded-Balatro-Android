@echo off
setlocal enabledelayedexpansion

:: Get the current user's name and define paths
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set MODS_DIR=%BALATRO_DIR%\Mods
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua
:: Find the folder containing "smods"
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "smods" >nul && set STEAMMOD_DIR=%%D
)
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
:: Check for Pokermon mod
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "pokermon" >nul && set POKERMON_DIR=%%D
)

:: If Pokermon mod is found, copy setup.lua to BALATRO_DIR\pokermon
if defined POKERMON_DIR (
    mkdir "%BALATRO_DIR%\pokermon" 2>nul
    if exist "%POKERMON_DIR%\setup.lua" (
        copy /Y "%POKERMON_DIR%\setup.lua" "%BALATRO_DIR%\pokermon\setup.lua"
    )
)


:: Copy files from Talisman mod
copy /Y "%USERPROFILE%\AppData\Roaming\Balatro\Mods\Talisman\nativefs.lua" "%NATIVEFS_DIR%" >nul 2>&1

:: Copy json.lua and nativefs.lua from mods with libs folder
for /d %%D in ("%MODS_DIR%\*") do (
    if exist "%%D\libs\json\json.lua" (
        copy /Y "%%D\libs\json\json.lua" "%BALATRO_DIR%\json.lua" >nul 2>&1
    )
    if exist "%%D\libs\nativefs\nativefs.lua" (
        copy /Y "%%D\libs\nativefs\nativefs.lua" "%BALATRO_DIR%\nativefs.lua" >nul 2>&1
    )
)

:: Copy files from the Steammod directory
if defined STEAMMOD_DIR (
    copy /Y "%STEAMMOD_DIR%\version.lua" "%SMODS_DIR%" >nul 2>&1
)

xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1
echo Done.
endlocal
exit /b
