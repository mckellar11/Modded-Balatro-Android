@echo off
setlocal enabledelayedexpansion        ----With delayed expansion enabled, variables can be evaluated at runtime, which means you can use variables inside loops or if-else blocks and their values will be updated as the script runs.

:: Get the current user's name and define paths       ---description says it but it defines you, balatro install location, mod dir, and then the soon to be created folders and files             
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set MODS_DIR=%BALATRO_DIR%\Mods
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua

:: Find the folder containing "smods"   --- this was missing
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

:: Check for Flower Pot mod                                              ----- if its here take the files and rename them, and moves them 
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

:: Copy files from Talisman mod
copy /Y "%USERPROFILE%\AppData\Roaming\Balatro\Mods\Talisman\nativefs.lua" "%NATIVEFS_DIR%" >nul 2>&1

:: Copy json.lua and nativefs.lua from mods with libs folder        ----- this was also missing
for /d %%D in ("%MODS_DIR%\*") do (
    if exist "%%D\libs\json.lua" (
        copy /Y "%%D\libs\json.lua" "%BALATRO_DIR%\json.lua" >nul 2>&1
    )
    if exist "%%D\libs\nativefs.lua" (
        copy /Y "%%D\libs\nativefs.lua" "%BALATRO_DIR%\nativefs.lua" >nul 2>&1
    )
)

:: Copy files from the Steammod directory  ----- reformated with new definition
if defined STEAMMOD_DIR (
    copy /Y "%STEAMMOD_DIR%\version.lua" "%SMODS_DIR%" >nul 2>&1
)

xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1                    ----should be the last "required files" and lovely dumps

echo Done.
endlocal
exit /b
