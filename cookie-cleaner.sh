#!/bin/bash
# Remove non-whitelisted sites from Cookies database

DATABASE="/home/${USER}/.local/share/qutebrowser/webengine/Cookies"
WHITELIST="/home/${USER}/.config/qutebrowser-cookiecleaner.list"
OUTPUT="/home/${USER}/.qutebrowser-clear-cookies-log"

# To exclude the whitelisted hosts
WHITE='SELECT DISTINCT(host_key) FROM Cookies WHERE '
for HOST in $(cat $WHITELIST); do
        WHITE="${WHITE}"' (host_key LIKE "%'$HOST'") OR'
done

# Remove last "OR"
WHITE=${WHITE%OR}

# Dangerous command to remove cookies
CMD="DELETE FROM Cookies WHERE host_key NOT IN ($WHITE)"
# Not so dangerous debug SQL
DBG="SELECT * FROM Cookies WHERE host_key NOT IN ($WHITE)"

if [ "$1" == "debug" ]; then
        OUTPUT="/dev/stdout"
        echo "DEBUG" > $OUTPUT
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
else
        sqlite3 ${DATABASE} "${DBG}" > $OUTPUT
        sqlite3 ${DATABASE} "${CMD}"
fi


exit $?
