@echo off
setlocal enabledelayedexpansion                                ----With delayed expansion enabled, variables can be evaluated at runtime, which means you can use variables inside loops or if-else blocks and their values will be updated as the script runs.

:: Get the current user's name and define paths                  ---description says it but it defines you, balatro install location, mod dir, and then the soon to be created folders and files
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set MODS_DIR=%BALATRO_DIR%\Mods
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua

:: Create necessary folders                    < ----they say it here 
mkdir "%NATIVEFS_DIR%" 2>nul
mkdir "%SMODS_DIR%" 2>nul

:: Create lovely.lua file                        <----and here. tells lovely file what to have in it
echo return { > "%LOVELY_FILE%"
echo   repo = "https://github.com/ethangreen-dev/lovely-injector", >> "%LOVELY_FILE%"
echo   version = "0.7.1", >> "%LOVELY_FILE%"
echo   mod_dir = "/data/data/com.unofficial.balatro/files/save/game/Mods", >> "%LOVELY_FILE%"
echo } >> "%LOVELY_FILE%"

:: Check for Flower Pot mod                            <----- just keep reading here
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "flower.pot" >nul && set FP_DIR=%%D
)

if defined FP_DIR (                                                        ----- if its here take the files and rename them, and moves them 
    set FP_LIBS=!FP_DIR!\libs
    if exist "!FP_LIBS!\json.lua" (
        copy /Y "!FP_LIBS!\json.lua" "%BALATRO_DIR%\FP_json.lua"
    )
    if exist "!FP_LIBS!\nativefs.lua" (
        copy /Y "!FP_LIBS!\nativefs.lua" "%BALATRO_DIR%\FP_nativefs.lua"
    )
)

:: Copy files from other mods                                                                                ----should be the last "required files" and lovely dumps
copy /Y "%USERPROFILE%\AppData\Roaming\Balatro\Mods\Talisman\nativefs.lua" "%NATIVEFS_DIR%" >nul 2>&1
copy /Y "%MODS_DIR%\smods-main\version.lua" "%SMODS_DIR%" >nul 2>&1
xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1

echo Done.
endlocal
exit /b
