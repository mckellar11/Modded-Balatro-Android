@echo off ---@echo off makes sure only the output of the commands (not the commands themselves) will be shown.
setlocal   --- It helps to ensure that variables in the script won’t affect the system or other processes outside the script.

:: Get the current user's directory             ----sets variables for to be tinkered with
set USERPROFILE=%USERPROFILE%                   --- who you is
set BALATRO_DIR=%USERPROFILE%\AppData\Roaming\Balatro  --- sets balatro location to your profiles /roaming/ (download script and change with text editor if its differnet but it shouldnt be..)
set NATIVEFS_DIR=%BALATRO_DIR%\nativefs          --- folder for talisman nativefs 
set SMODS_DIR=%BALATRO_DIR%\SMODS                --- folder for version.lua is in
set LOVELY_FILE=%BALATRO_DIR%\lovely.lua         ---the lovely file that was created
set FP_JSON=%BALATRO_DIR%\FP_json.lua            --- Flower Pot's json (stat tracker mod, this is something i use in my config.)
set FP_NATIVEFS=%BALATRO_DIR%\FP_nativefs.lua    ---- same but for nativefs
set FUNCTIONS_DIR=%BALATRO_DIR%\functions        ---this was a folder from dump
set ENGINE_DIR=%BALATRO_DIR%\engine              --- samesies

:: Delete folders and contents        -deletes the folders we addressed 
rd /s /q "%NATIVEFS_DIR%" 2>nul
rd /s /q "%SMODS_DIR%" 2>nul
rd /s /q "%FUNCTIONS_DIR%" 2>nul
rd /s /q "%ENGINE_DIR%" 2>nul

:: Delete all .txt and .lua files            ---- deletes anything else with .txt or .lua (even FP_nativefs.lua, regular nativefs and the json files. lovely.lua tooooo
del /f /q "%BALATRO_DIR%\*.txt" 2>nul
del /f /q "%BALATRO_DIR%\*.lua" 2>nul

echo Cleanup complete.                          - finito
endlocal
exit /b
 
