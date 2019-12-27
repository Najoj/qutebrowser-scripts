#!/bin/bash
# Remove non-whitelisted sites from Cookies database

DATABASE="/home/${USER}/.local/share/qutebrowser/webengine/Cookies"
HOST="$(echo $QUTE_URL | cut -d\/ -f3 | sed "s/^www.//")"

# Dangerous command to remove cookies
CMD="DELETE FROM Cookies WHERE"' (host_key LIKE "%'$HOST'")'
# Not so dangerous debug SQL
DBG="DELETE FROM Cookies WHERE"' (host_key LIKE "%'$HOST'")'

if [ "$1" == "debug" ]; then
        OUTPUT="/dev/stdout"
        echo "DEBUG" > $OUTPUT
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
else
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
        sqlite3 ${DATABASE} "${CMD}"
echo "message-info \"removed cookies from '${HOST}'\"" >> ${QUTE_FIFO}
fi


exit $?
