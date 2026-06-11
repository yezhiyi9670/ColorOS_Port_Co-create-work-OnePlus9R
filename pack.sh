#!/bin/sh

# Usage examples:
# $ pack.sh hwui_vulkan_enable (packs one dir)
# $ pack.sh (packs all)
# Will output zip to the parent directory of the current workspace.

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

pack_dir() {
    cd "$SCRIPT_DIR/$1"
    local out="$SCRIPT_DIR/../$1.zip"
    if [[ -f "$out" ]]; then
        rm "$out"
    fi
    7z a "$out" *
    cd "$SCRIPT_DIR"
}

if [[ "$1" != "" ]]; then
    if [[ -f "$1/module.prop" ]]; then
        pack_dir "$1"
    else
        echo "Module not found: $1"
    fi
else
    for subdir in $(ls .); do
        if [[ -f "$subdir/module.prop" ]]; then
            pack_dir "$subdir"
        fi
    done
fi
