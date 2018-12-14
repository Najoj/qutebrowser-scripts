#!/bin/bash

# Whitelist file
FILE=/home/${USER}/.config/qutebrowser-cookiecleaner.list
TMP=${FILE}.tmp
# Host
HOST=$(echo $QUTE_URL | cut -d\/ -f3 | sed "s/^www.//")
# Whitelist it
echo $HOST >> $FILE
sort -u $FILE > $TMP
cp $TMP $FILE

