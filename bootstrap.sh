#!/bin/bash

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_CONFIG_LOG_FILE=/var/log/munin/munin-node-configure.log
MUNIN_LOG_FILE=/var/log/munin/munin-node.log

if [ ! -z "$ALLOW" ]; then
    echo $ALLOW >> $MUNIN_CONFIGURATION_FILE
fi

for pl in $PLUGINS ; do
	# We need to be able to handle renaming while linking
	# (for cases such as foo/blah_ -> plugins/blah_example)
	# so let's allow each plugin spec to be of the form:
	#
	#  path/plugin[:targetname]
	#
	# That is, path/plugin is mandatory.
	# Targetname is optional, but must be separated by a colon
	# If targetname is not specified, the original name of the
	# plugin is used
	plugin=${pl%:*}
	target=${pl#*:}

	# This should work, even if $target is empty
	ln -sf /opt/munin/contrib/plugins/$plugin /etc/munin/plugins/$target

done	

tail -f $MUNIN_CONFIG_LOG_FILE $MUNIN_LOG_FILE
