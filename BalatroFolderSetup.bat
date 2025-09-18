@echo off
setlocal enabledelayedexpansion

:: Get the current user's name and define paths
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set MODS_DIR=%BALATRO_DIR%\Mods
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua

:: Find the folder containing "smods" or "steamodded"
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "smods steamodded" >nul && set STEAMMOD_DIR=%%D
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

:: Check for Flower Pot mod (matches "flower pot", "flower-pot", "flower_pot", etc.)
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "flower.*pot" >nul && set FP_DIR=%%D
)
:: If Flower Pot mod is found, and copy required files and rename
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
:: Check for Cartomancer mod
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "cartomancer" >nul && set CARTOMANCER_DIR=%%D
)
:: If Cartomancer mod is found, create the cartomancer folder and copy required files
if defined CARTOMANCER_DIR (
    mkdir "%BALATRO_DIR%\cartomancer" 2>nul
    if exist "%CARTOMANCER_DIR%\cartomancer.lua" (
        copy /Y "%CARTOMANCER_DIR%\cartomancer.lua" "%BALATRO_DIR%\cartomancer\cartomancer.lua"
    )
    if exist "%CARTOMANCER_DIR%\libs\nativefs.lua" (
        copy /Y "%CARTOMANCER_DIR%\libs\nativefs.lua" "%BALATRO_DIR%\cartomancer\nfs.lua"
    )
    if exist "%CARTOMANCER_DIR%\internal\init.lua" (
        copy /Y "%CARTOMANCER_DIR%\internal\init.lua" "%BALATRO_DIR%\cartomancer\init.lua"
    )
)
:: Search for the folder containing "SystemClock" (with possible variations)
for /d %%D in ("%MODS_DIR%\*") do (
    echo %%~nxD | findstr /i "SystemClock" >nul && set SYSTEMCLOCK_DIR=%%D
)
:: If the folder is found, create the systemclock folder and copy files based on the patches
if defined SYSTEMCLOCK_DIR (
    mkdir "%BALATRO_DIR%\systemclock" 2>nul

    :: Draggable Container
    if exist "%SYSTEMCLOCK_DIR%\src\draggable_container.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\draggable_container.lua" "%BALATRO_DIR%\systemclock\draggablecontainer.lua" >nul 2>&1
    )
    :: Utilities
    if exist "%SYSTEMCLOCK_DIR%\src\utilities.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\utilities.lua" "%BALATRO_DIR%\systemclock\utilities.lua" >nul 2>&1
    )
    :: Config
    if exist "%SYSTEMCLOCK_DIR%\src\config.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\config.lua" "%BALATRO_DIR%\systemclock\config.lua" >nul 2>&1
    )
    :: Config UI
    if exist "%SYSTEMCLOCK_DIR%\src\config_ui.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\config_ui.lua" "%BALATRO_DIR%\systemclock\config_ui.lua" >nul 2>&1
    )
    :: Clock UI
    if exist "%SYSTEMCLOCK_DIR%\src\clock_ui.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\clock_ui.lua" "%BALATRO_DIR%\systemclock\clock_ui.lua" >nul 2>&1
    )
    :: Locale
    if exist "%SYSTEMCLOCK_DIR%\src\locale.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\locale.lua" "%BALATRO_DIR%\systemclock\locale.lua" >nul 2>&1
    )
    :: Logger
    if exist "%SYSTEMCLOCK_DIR%\src\logger.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\logger.lua" "%BALATRO_DIR%\systemclock\logger.lua" >nul 2>&1
    )
    :: Core
    if exist "%SYSTEMCLOCK_DIR%\src\core.lua" (
        copy /Y "%SYSTEMCLOCK_DIR%\src\core.lua" "%BALATRO_DIR%\systemclock\core.lua" >nul 2>&1
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
    copy /Y "%STEAMMOD_DIR%\release.lua" "%SMODS_DIR%" >nul 2>&1
)

xcopy /E /Y "%MODS_DIR%\lovely\dump\*" "%BALATRO_DIR%" >nul 2>&1
echo Done.
endlocal
exit /b
