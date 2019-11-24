#!/bin/bash

FILE="/home/${USER}/.local/share/qutebrowser/history.sqlite"
TIME="$(date +%s --date="6 months ago")"

DBG="select * from CompletionHistory where last_atime < $TIME"
CMD="delete from CompletionHistory where last_atime < $TIME"

# if not debug, we'll execute command and only log
if [ "$1" == "debug" ]; then
        OUTPUT="/dev/stdout"
        echo "DEBUG" > $OUTPUT
else
        OUTPUT="/home/${USER}/.qutebrowser-delete-history-log"
        sqlite3 ${FILE} "${CMD}"
fi

sqlite3 ${FILE} "${DBG}" > $OUTPUT

exit $?
