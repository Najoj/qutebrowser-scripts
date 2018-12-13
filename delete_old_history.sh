#!/bin/bash
HISTFILE="/home/jojan/.local/share/qutebrowser/history.sqlite"
CMD="delete from CompletionHistory where last_atime < "
# CMD="select * from CompletionHistory where last_atime < "
TIME="$(date +%s --date="6 months ago")";

CMD="$CMD $TIME"
sqlite3 ${HISTFILE} "${CMD}"

exit $?
