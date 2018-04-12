#!/usr/bin/env bash

DIR="$(dirname "${BASH_SOURCE[0]}")"

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

source $DIR/git-prompt.sh

# this function is meant to be run from the root dir of your
# collection of git projects, your "projects" folder, for instance
function gitlsd() {
	FILES=`ls`
	BASE=`pwd`

	while read line; do
		DIR="$BASE/$line"
		COLOR='\033[01;34m'
		NC='\033[0m'
		if [ -d "$line" ]; then
			if [ "$color_prompt" = yes ]; then
				cd $DIR && printf "${COLOR}$(sed 's/\.\///' <<< $line)${NC} $(__git_ps1 " (%s)")\n" && cd ..
			else
				cd $DIR && echo "$(sed 's/\.\///' <<< $line)" $(__git_ps1 " (%s)") && cd ..
			fi
		else
			echo "$line"
		fi
	done <<< $FILES
}

confirm () {
    read -r -p "${1:-Are you sure? [y/N]} " response </dev/tty
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

findin () {
	find . -iname "*$1*"
}

# call with `serve portNum`
# serves current directory on specified port
# trys to run with python3 but falls back to python2
serve() ( 
	python3 -m http.server "$1";
	if [ $? -ne 0 ]; then
		python -m SimpleHTTPServer "$1";
	fi
)