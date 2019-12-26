#!/bin/bash

DATABASE="/home/${USER}/.local/share/qutebrowser/history.sqlite"
TIME="$(date +%s --date="6 months ago")"

DBG="select * from CompletionHistory where last_atime < $TIME"
CMD="delete from CompletionHistory where last_atime < $TIME"

OUTPUT="/home/${USER}/.qutebrowser-delete-history-log"

# if not debug, we'll execute command and only log
if [ "$1" == "debug" ]; then
        OUTPUT="/dev/stdout"
        echo "DEBUG" > $OUTPUT
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
else
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
        sqlite3 ${DATABASE} "${CMD}"
fi

exit $?
