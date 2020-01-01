#!/bin/bash

# Whitelist file
FILE="/home/${USER}/.config/qutebrowser-cookiecleaner.list"
TMP="${FILE}.tmp"
# Host
HOST="$(echo $QUTE_URL | cut -d\/ -f3 | sed "s/^www.//")"
# Remove from or add to list
if [ "$1" == "delete" ]; then
        # Remove host from file
        grep -v "^${HOST}$" $FILE > $TMP
        # Inform user
        MSG="\"removed '${HOST}' from whitelist\""
else
        # Whitelist it
        echo $HOST >> $FILE
        sort -u $FILE > $TMP
        MSG="\"added '${HOST}' to whitelist\""
fi
# Save new file
cp $TMP $FILE
# Inform user
echo "message-info $MSG" >> ${QUTE_FIFO}
