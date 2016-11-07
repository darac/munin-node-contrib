#!/bin/sh

exec /opt/munin/contrib/tools/pypmmn/pypmmn/pypmmn.py -p 4949 -d /etc/munin/plugins --no-daemon
