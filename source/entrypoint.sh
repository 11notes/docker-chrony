#!/bin/ash

#remove chrony.pid which gets stuck if container is not destroyed!

if [ -e /run/chrony.pid ]
then
        rm -f /run/chrony.pid
fi

chronyd -f /chrony/etc/chrony.conf -d