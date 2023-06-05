#!/bin/bash

BASHRC_FILE=~/.bashrc
BASHRC_SKEL_FILE=/etc/skel/.bashrc
CUSTOM_BASHRC_FILE=.bashrc_custom

# Get confirmation that bashrc is resetting, if not exit
read -p "Do you want to reset your .bashrc file? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted!"
    exit 1
fi

# Backup existing .bashrc file
if [ -f "$BASHRC_FILE" ]; then
    mv "$BASHRC_FILE" "$BASHRC_FILE.bak"
    echo "Existing .bashrc file backed up as .bashrc.bak"
fi

# if exist bashrc_skel file, copy it to .bashrc
if [ -f "$BASHRC_SKEL_FILE" ]; then
    cp "$BASHRC_SKEL_FILE" "$BASHRC_FILE"
    echo "Copied .bashrc_skel to .bashrc"
else
    echo "No .bashrc_skel file found, creating new .bashrc file"
    touch "$BASHRC_FILE"
fi

# Append custom .bashrc content to existing .bashrc
cat "$CUSTOM_BASHRC_FILE" >> "$BASHRC_FILE"

echo "Custom Bash prompt installed successfully!"
echo "Please reload your Bash configuration by running: source ~/.bashrc or open a new terminal"

