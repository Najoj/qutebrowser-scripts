#!/usr/bin/env bash
# USER AGENT SWITCHER FOR QUTEBROWSER

## SETTINGS
# File with your user agents. One per line.
USER_AGENTS="${HOME}/.local/share/qutebrowser/userscripts/user-agents"
# Make sure the file exist
if ! [ -f $USER_AGENTS ]; then
    echo "message-warning \"file $USER_AGENTS does not exist" >> $QUTE_FIFO
    exit 1
fi

# Update time
TIME="10m"
# Setter string
SET=":set network user-agent"
# To re-spawn the script
SPAWN=":spawn --userscript $0"

if [ -e "$USER_AGENTS" ]; then
    # Get new user agent at random
    AGENT="$(shuf "$USER_AGENTS" | head -1)"
    # Set new user agent
    echo "$SET \"$AGENT\""  >> "$QUTE_FIFO"
    # Wait for next change
    sleep   $TIME
    # Re-spawn
    echo "$SPAWN" >> "$QUTE_FIFO"
fi
