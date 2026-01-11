#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.config/opencode"

echo "OpenCode Configuration Bootstrap"
echo "================================="
echo "Source: $SCRIPT_DIR"
echo "Target: $TARGET_DIR"
echo ""

# Check if target exists
if [ -e "$TARGET_DIR" ]; then
    if [ -L "$TARGET_DIR" ]; then
        CURRENT_LINK="$(readlink "$TARGET_DIR")"
        if [ "$CURRENT_LINK" = "$SCRIPT_DIR" ]; then
            echo "Symlink already exists and points to correct location."
            exit 0
        else
            echo "Symlink exists but points to: $CURRENT_LINK"
            read -p "Replace with new symlink? [y/N] " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$TARGET_DIR"
            else
                echo "Aborted."
                exit 1
            fi
        fi
    else
        echo "$TARGET_DIR exists and is not a symlink."
        echo "This may contain existing configuration."
        read -p "Replace with symlink? (existing config will be backed up) [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            BACKUP_DIR="$TARGET_DIR.backup.$(date +%Y%m%d%H%M%S)"
            echo "Backing up to: $BACKUP_DIR"
            mv "$TARGET_DIR" "$BACKUP_DIR"
        else
            echo "Aborted."
            exit 1
        fi
    fi
fi

# Ensure parent directory exists
mkdir -p "$(dirname "$TARGET_DIR")"

# Create symlink
ln -s "$SCRIPT_DIR" "$TARGET_DIR"
echo "Created symlink: $TARGET_DIR -> $SCRIPT_DIR"
echo ""
echo "Done! OpenCode will now use configuration from this repository."
