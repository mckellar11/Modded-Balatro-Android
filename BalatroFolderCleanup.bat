@echo off
setlocal

:: Get the current user's directory
set USERPROFILE=%USERPROFILE%
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs
set SMODS_DIR=%BALATRO_DIR%\SMODS
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua
set FP_JSON=%BALATRO_DIR%\FP_json.lua
set FP_NATIVEFS=%BALATRO_DIR%\FP_nativefs.lua
set FUNCTIONS_DIR=%BALATRO_DIR%\functions
set ENGINE_DIR=%BALATRO_DIR%\engine

:: Delete folders and contents
rd /s /q "%NATIVEFS_DIR%" 2>nul
rd /s /q "%SMODS_DIR%" 2>nul
rd /s /q "%FUNCTIONS_DIR%" 2>nul
rd /s /q "%ENGINE_DIR%" 2>nul

:: Delete files
del /f /q "%LOVELY_FILE%" 2>nul
if exist "%FP_JSON%" del /f /q "%FP_JSON%"
if exist "%FP_NATIVEFS%" del /f /q "%FP_NATIVEFS%"

:: Delete all .txt and .lua files
del /f /q "%BALATRO_DIR%\*.txt" 2>nul
del /f /q "%BALATRO_DIR%\*.lua" 2>nul

echo Cleanup complete.
endlocal
exit /b
