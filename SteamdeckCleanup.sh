#!/bin/bash

# Get the current user's directory
USERPROFILE="$HOME"
BALATRO_DIR="$USERPROFILE/.steam/steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro"
NATIVEFS_DIR="$BALATRO_DIR/nativefs"
SMODS_DIR="$BALATRO_DIR/SMODS"
LOVELY_FILE="$BALATRO_DIR/lovely.lua"
FP_JSON="$BALATRO_DIR/FP_json.lua"
FP_NATIVEFS="$BALATRO_DIR/FP_nativefs.lua"
FUNCTIONS_DIR="$BALATRO_DIR/functions"
ENGINE_DIR="$BALATRO_DIR/engine"

# Delete folders and contents
rm -rf "$NATIVEFS_DIR" 2>/dev/null
rm -rf "$SMODS_DIR" 2>/dev/null
rm -rf "$FUNCTIONS_DIR" 2>/dev/null
rm -rf "$ENGINE_DIR" 2>/dev/null
rm -rf "$BALATRO_DIR/pokermon" 2>/dev/null
rm -rf "$BALATRO_DIR/cartomancer" 2>/dev/null
rm -rf "$BALATRO_DIR/systemclock" 2>/dev/null

# Delete files
rm -f "$LOVELY_FILE" 2>/dev/null
rm -f "$FP_JSON" 2>/dev/null
rm -f "$FP_NATIVEFS" 2>/dev/null

# Delete all .txt and .lua files in Balatro directory
rm -f "$BALATRO_DIR"/*.txt 2>/dev/null
rm -f "$BALATRO_DIR"/*.lua 2>/dev/null

echo "Cleanup complete."
exit 0
