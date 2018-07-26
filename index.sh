#!/usr/bin/env bash

DIR="$(dirname "${BASH_SOURCE[0]}")"

source $DIR/bashrc.sh
source $DIR/bash_aliases.sh
source $DIR/bash_functions.sh
source $DIR/bash_path.sh

# the following section relys on a folder of local scripts and settings contained
# in a folder in a location specificied by the LOCAL_SETTINGS variable
LOCAL_SETTINGS="$DIR/local_settings"

for i in $LOCAL_SETTINGS/*; do
	if [ -r $i ]; then
		. $i
	fi
done
