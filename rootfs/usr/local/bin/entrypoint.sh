#!/bin/ash
if [ -e /run/chrony.pid ]
then
        rm -f /run/chrony.pid
fi

# :: Run
exec "$@"