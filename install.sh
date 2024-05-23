#!/bin/bash

BASHRC_FILE=~/.bashrc
BASHRC_SKEL_FILE=/etc/skel/.bashrc
PROMPT_FILE=prompt
HOME_PROMPT_FILE=~/.$PROMPT_FILE
SCREEN_FILE=screenrc

# Get confirmation that bashrc is resetting, if not exit
echo "This script will install a custom Bash prompt to your .bashrc file."
read -p "Do you want to continue? [Y/n] " answer
answer=${answer:-Y}
echo

if [[ ! $answer =~ ^[Yy]$ ]]; then
    echo "Aborted!"
    exit 1
fi

# Copy prompt file to home directory
cp "$PROMPT_FILE" "$HOME_PROMPT_FILE"

# Backup existing .bashrc file
if [ -f "$BASHRC_FILE" ]; then
    mv "$BASHRC_FILE" "$BASHRC_FILE.bak"
    echo "Existing .bashrc file backed up as .bashrc.bak"
fi

# Copy .bashrc from /etc/skel if not present
if [ ! -f "$BASHRC_FILE" ]; then
    cp "$BASHRC_SKEL_FILE" "$BASHRC_FILE"
    echo "Copied .bashrc from /etc/skel"
fi

# Append below snippet to .bashrc if not already present
if ! grep -q "$HOME_PROMPT_FILE" "$BASHRC_FILE"; then
    echo "# Load custom Bash prompt" >> "$BASHRC_FILE"
    echo "if [ -f $HOME_PROMPT_FILE ]; then" >> "$BASHRC_FILE"
    echo "    . $HOME_PROMPT_FILE" >> "$BASHRC_FILE"
    echo "fi" >> "$BASHRC_FILE"
fi

# Append custom .screenrc content to existing .screenrc
cat "$SCREEN_FILE" > ~/.screenrc

echo "Custom Bash prompt installed successfully!"
echo "Please reload your Bash configuration by running: source ~/.bashrc or open a new terminal"

