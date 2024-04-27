#!/bin/bash

BASHRC_FILE=~/.bashrc
PROMPT_FILE=prompt
TARGET_PROMPT_FILE=~/.$PROMPT_FILE

# Get confirmation that bashrc is resetting, if not exit
echo "This script will install a custom Bash prompt to your .bashrc file."
read -p "Do you want to continue? [Y/n] " -r

echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted!"
    exit 1
fi

# Backup existing .bashrc file
if [ -f "$BASHRC_FILE" ]; then
    cp "$BASHRC_FILE" "$BASHRC_FILE.bak"
    echo "Existing .bashrc file backed up as .bashrc.bak"
fi

# Append below snippet to .bashrc if not already present
if ! grep -q "$TARGET_PROMPT_FILE" "$BASHRC_FILE"; then
    echo "# Load custom Bash prompt" >> "$BASHRC_FILE"
    echo "if [ -f $TARGET_PROMPT_FILE ]; then" >> "$BASHRC_FILE"
    echo "    . $TARGET_PROMPT_FILE" >> "$BASHRC_FILE"
    echo "fi" >> "$BASHRC_FILE"
fi

# Create custom Bash prompt file
cp $PROMPT_FILE $TARGET_PROMPT_FILE

echo "Custom Bash prompt installed successfully!"
echo "Please reload your Bash configuration by running: source ~/.bashrc or open a new terminal"

