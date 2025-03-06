#!/bin/bash

# Define paths
USERPROFILE="/home/deck/.steam/steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser"
BALATRO_DIR="$USERPROFILE/AppData/Roaming/Balatro"
MODS_DIR="$BALATRO_DIR/Mods"
NATIVEFS_DIR="$BALATRO_DIR/nativefs"
SMODS_DIR="$BALATRO_DIR/SMODS"
LOVELY_FILE="$BALATRO_DIR/lovely.lua"

# Find the Steam mod directory (folder containing "smods")
for D in "$MODS_DIR"/*; do
    if [[ "$(basename "$D")" =~ smods ]]; then
        STEAMMOD_DIR="$D"
        break
    fi
done

# Create necessary folders
mkdir -p "$NATIVEFS_DIR" "$SMODS_DIR"

# Create lovely.lua file
cat <<EOL > "$LOVELY_FILE"
return {
  repo = "https://github.com/ethangreen-dev/lovely-injector",
  version = "0.7.1",
  mod_dir = "/data/data/com.unofficial.balatro/files/save/game/Mods",
}
EOL
# Find and handle Flower Pot mod
temp=""
for D in "$MODS_DIR"/*; do
    if [[ "$(basename "$D" | tr '[:upper:]' '[:lower:]')" =~ flower[-_]*pot|pot[-_]*flower ]]; then
        FP_DIR="$D"
        temp="$D/libs"
        break
    fi
done

if [[ -n "$FP_DIR" ]]; then
    if [[ -f "$temp/json.lua" ]]; then
        cp -f "$temp/json.lua" "$BALATRO_DIR/FP_json.lua"
    fi
    if [[ -f "$temp/nativefs.lua" ]]; then
        cp -f "$temp/nativefs.lua" "$BALATRO_DIR/FP_nativefs.lua"
    fi
fi

# Find and handle Pokermon mod
for D in "$MODS_DIR"/*; do
    if [[ "$(basename "$D" | tr '[:upper:]' '[:lower:]')" =~ pokermon ]]; then
        POKERMON_DIR="$D"
        break
    fi
done


if [[ -n "$POKERMON_DIR" ]]; then
    mkdir -p "$BALATRO_DIR/pokermon"
    [[ -f "$POKERMON_DIR/setup.lua" ]] && cp -f "$POKERMON_DIR/setup.lua" "$BALATRO_DIR/pokermon/setup.lua"
fi

# Find and handle Cartomancer mod
for D in "$MODS_DIR"/*; do
    if [[ "$(basename "$D" | tr '[:upper:]' '[:lower:]')" =~ cartomancer ]]; then
        CARTOMANCER_DIR="$D"
        break
    fi
done

if [[ -n "$CARTOMANCER_DIR" ]]; then
    mkdir -p "$BALATRO_DIR/cartomancer"
    [[ -f "$CARTOMANCER_DIR/cartomancer.lua" ]] && cp -f "$CARTOMANCER_DIR/cartomancer.lua" "$BALATRO_DIR/cartomancer/cartomancer.lua"
    [[ -f "$CARTOMANCER_DIR/libs/nativefs.lua" ]] && cp -f "$CARTOMANCER_DIR/libs/nativefs.lua" "$BALATRO_DIR/cartomancer/nfs.lua"
    [[ -f "$CARTOMANCER_DIR/internal/init.lua" ]] && cp -f "$CARTOMANCER_DIR/internal/init.lua" "$BALATRO_DIR/cartomancer/init.lua"
fi

# Find and handle SystemClock mod
for D in "$MODS_DIR"/*; do
    if [[ "$(basename "$D")" =~ SystemClock ]]; then
        SYSTEMCLOCK_DIR="$D"
        break
    fi
done

if [[ -n "$SYSTEMCLOCK_DIR" ]]; then
    mkdir -p "$BALATRO_DIR/systemclock"
    for file in draggable_container utilities config config_ui clock_ui locale logger core; do
        src_file="$SYSTEMCLOCK_DIR/src/$file.lua"
        dest_file="$BALATRO_DIR/systemclock/$file.lua"
        
        # Special case for draggable_container: remove the underscore in the filename
        if [[ "$file" == "draggable_container" ]]; then
            dest_file="$BALATRO_DIR/systemclock/${file//_/}.lua"  # Removes underscores, keeps .lua extension
        fi

        [[ -f "$src_file" ]] && cp -f "$src_file" "$dest_file"
    done
fi

# Copy files from Talisman mod
cp -f "$MODS_DIR/Talisman/nativefs.lua" "$NATIVEFS_DIR/" 2>/dev/null

# Copy json.lua and nativefs.lua from mods with libs folder
for D in "$MODS_DIR"/*; do
    [[ -f "$D/libs/json/json.lua" ]] && cp -f "$D/libs/json/json.lua" "$BALATRO_DIR/json.lua"
    [[ -f "$D/libs/nativefs/nativefs.lua" ]] && cp -f "$D/libs/nativefs/nativefs.lua" "$BALATRO_DIR/nativefs.lua"
done

# Copy files from the Steammod directory
[[ -n "$STEAMMOD_DIR" && -f "$STEAMMOD_DIR/version.lua" ]] && cp -f "$STEAMMOD_DIR/version.lua" "$SMODS_DIR/"

# Copy lovely dump folder
cp -r "$MODS_DIR/lovely/dump/"* "$BALATRO_DIR/" 2>/dev/null

echo "Done."
exit 0
