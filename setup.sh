#!/bin/bash

TARGET_DIR=~/gitthings/linuxconfigs
TARGET_SCRIPT="$TARGET_DIR/setup.sh"
CONFIG_DIRS=("alacritty" "conky" "picom" "qtile" "rofi")
CONFIG_BASE=~/.config

CURRENT_SCRIPT="$(realpath "$0")"
CURRENT_DIR="$(dirname "$CURRENT_SCRIPT")"

if [[ "$CURRENT_SCRIPT" != "$TARGET_SCRIPT" ]]; then
    mkdir -p "$TARGET_DIR"
    cp -r "$CURRENT_DIR/"* "$TARGET_DIR/"
    chmod +x "$TARGET_SCRIPT"
    echo "done: $TARGET_SCRIPT"
    exec "$TARGET_SCRIPT" "$@"
fi

for dir in "${CONFIG_DIRS[@]}"; do
    SRC="$TARGET_DIR/$dir"
    DEST="$CONFIG_BASE/$dir"

    if [[ -d "$DEST" || -f "$DEST" ]]; then
        mv "$DEST" "$DEST.old"
    fi

    mkdir -p "$CONFIG_BASE"
    cp -r "$SRC" "$DEST"
done

if [[ -f "$TARGET_DIR/mypackages.txt" ]]; then
    yay -S --noconfirm $(cat ~/gitthings/linuxconfigs/mypackages.txt)
fi
