#!/bin/bash

# Whitelist file
FILE=/home/${USER}/.config/qutebrowser-cookiecleaner.list
TMP=${FILE}.tmp
# Host
HOST=$(echo $QUTE_URL | cut -d\/ -f3 | cut -d\. -f2-3)
# Whitelist it
echo $HOST >> $FILE
sort -u $FILE > $TMP
cp $TMP $FILE
# Inform user
echo "message-info \"added '${HOST}' to whitelist\"" >> ${QUTE_FIFO}
