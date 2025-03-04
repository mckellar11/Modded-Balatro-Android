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

:: Initialize lovely.lua
echo return { > "%LOVELY_FILE%"
echo   repo = "https://github.com/ethangreen-dev/lovely-injector", >> "%LOVELY_FILE%"
echo   version = "0.7.1", >> "%LOVELY_FILE%"
echo   mod_dir = "/data/data/com.unofficial.balatro/files/save/game/Mods", >> "%LOVELY_FILE%"
echo } >> "%LOVELY_FILE%"

:: Process mods
for /d %%D in ("%MODS_DIR%\*") do (
    set MOD_DIR=%%D
    set MOD_NAME=%%~nxD

    :: Check for Flower Pot mod
    if /i "!MOD_NAME!"=="flower.pot" (
        set FP_LIBS=!MOD_DIR!\libs
        if exist "!FP_LIBS!\json.lua" copy /Y "!FP_LIBS!\json.lua" "%BALATRO_DIR%\FP_json.lua" >nul 2>&1
        if exist "!FP_LIBS!\nativefs.lua" copy /Y "!FP_LIBS!\nativefs.lua" "%BALATRO_DIR%\FP_nativefs.lua" >nul 2>&1
    )

    :: Check for Pokermon mod
   echo !MOD_NAME! | findstr /i "pokermon" >nul
        mkdir "%BALATRO_DIR%\pokermon" 2>nul
        if exist "!MOD_DIR!\setup.lua" (
            copy /Y "!MOD_DIR!\setup.lua" "%BALATRO_DIR%\pokermon\setup.lua" >nul 2>&1
        
        )
    )
)
    :: Check for Cartomancer mod
    if /i "!MOD_NAME!"=="cartomancer" (
        mkdir "%BALATRO_DIR%\cartomancer" 2>nul
        if exist "!MOD_DIR!\cartomancer.lua" copy /Y "!MOD_DIR!\cartomancer.lua" "%BALATRO_DIR%\cartomancer\cartomancer.lua" >nul 2>&1
        if exist "!MOD_DIR!\libs\nativefs.lua" copy /Y "!MOD_DIR!\libs\nativefs.lua" "%BALATRO_DIR%\cartomancer\nfs.lua" >nul 2>&1
        if exist "!MOD_DIR!\internal\init.lua" copy /Y "!MOD_DIR!\internal\init.lua" "%BALATRO_DIR%\cartomancer\init.lua" >nul 2>&1
    )

    :: Check for SystemClock mod
if /i "!MOD_NAME!"=="systemclock" (
    mkdir "%BALATRO_DIR%\systemclock" 2>nul
    for %%F in (utilities config config_ui clock_ui locale logger core) do (
        if exist "!MOD_DIR!\src\%%F.lua" copy /Y "!MOD_DIR!\src\%%F.lua" "%BALATRO_DIR%\systemclock\%%F.lua" >nul 2>&1
    )
    if exist "!MOD_DIR!\src\draggable_container.lua" (
        copy /Y "!MOD_DIR!\src\draggable_container.lua" "%BALATRO_DIR%\systemclock\draggablecontainer.lua" >nul 2>&1
    )
)


    :: Copy json.lua and nativefs.lua from mods with libs folder
    if exist "!MOD_DIR!\libs\json\json.lua" copy /Y "!MOD_DIR!\libs\json\json.lua" "%BALATRO_DIR%\json.lua" >nul 2>&1
    if exist "!MOD_DIR!\libs\nativefs\nativefs.lua" copy /Y "!MOD_DIR!\libs\nativefs\nativefs.lua" "%BALATRO_DIR%\nativefs.lua" >nul 2>&1
)

:: Copy files from Talisman mod
copy /Y "%MODS_DIR%\Talisman\nativefs.lua" "%NATIVEFS_DIR%" >nul 2>&1

:: Copy files from the Steammod directory
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "smods" >nul && set STEAMMOD_DIR=%%D
)
if defined STEAMMOD_DIR (
    copy /Y "%STEAMMOD_DIR%\version.lua" "%SMODS_DIR%" >nul 2>&1
)

xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1

echo Done.
endlocal

