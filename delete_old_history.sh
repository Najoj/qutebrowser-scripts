#!/bin/bash

FILE="/home/${USER}/.local/share/qutebrowser/history.sqlite"
TIME="$(date +%s --date="6 months ago")";

CMD="delete from CompletionHistory where last_atime < "
# CMD="select * from CompletionHistory where last_atime < "

CMD="$CMD $TIME"
sqlite3 ${FILE} "${CMD}"

CMD="delete from History where atime < "
if [ $# -gt 0 ]; then
    CMD="select * from History where atime < "
fi

CMD="$CMD $TIME"
sqlite3 ${FILE} "${CMD}"

exit $?
