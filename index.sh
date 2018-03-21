#!/usr/bin/env bash

DIR="$(dirname "${BASH_SOURCE[0]}")"

source $DIR/bashrc.sh
source $DIR/bash_aliases.sh
source $DIR/bash_functions.sh

# import local path if file exists
if [ -f ./path.sh ]; then
    source $DIR/path.sh
fi

# import local sources
if [ -f ./local_sources.sh ]; then
    source $DIR/local_sources.sh
fi
