#!/bin/bash

BASHRC_FILE=~/.bashrc
CUSTOM_BASHRC_FILE=.bashrc_custom

# Backup existing .bashrc file
if [ -f "$BASHRC_FILE" ]; then
    mv "$BASHRC_FILE" "$BASHRC_FILE.bak"
    echo "Existing .bashrc file backed up as .bashrc.bak"
fi

# Append custom .bashrc content to existing .bashrc
cat "$CUSTOM_BASHRC_FILE" >> "$BASHRC_FILE"

echo "Custom Bash prompt installed successfully!"
echo "Please reload your Bash configuration by running: source ~/.bashrc"

