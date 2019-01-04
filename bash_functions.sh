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

function confirm () {
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

function findin () {
	find . -iname "*$1*"
}

# call with `serve portNum`
# serves current directory on specified port
# trys to run with python3 but falls back to python2
function serve() ( 
	python3 -m http.server "$1";
	if [ $? -ne 0 ]; then
		python -m SimpleHTTPServer "$1";
	fi
)

# concats several media files together
# resulting file will be called "output", with the same extension as the first file in the list
# requires ffmpeg be installed
function ffmpeg-concat() {
	rand=$RANDOM$RANDOM
	fname="list_$rand"

	args=("$@")
	numOfItems=${#args[@]}

	for (( i=0;i<$numOfItems;i++ )); do
		echo "* ${args[${i}]}"
		echo "file '${args[${i}]}'" >> $fname
	done

	ext=$(sed 's/.*\(\.[A-Za-z0-9]*\)$/\1/'<<<${args[0]})
	
	ffmpeg -f concat -i $fname -c copy "ouput$ext"
	rm "$fname"
}

# migrates repo to given url
# must be run from within a repo folder
function migrate-repo() {
	new_repo_url=$1
	NAME=new_repo_`date +%s`

	if [ -z $1 ]; then
		echo "You must provide a target url for the repo"
		exit
	fi

	for remote in `git branch -r|sed 's,origin/\|->\|HEAD,,g'`;
	do
		git checkout -b $remote
	done

	git remote add $NAME $new_repo_url
	git push -u $NAME --all
	git push -u $NAME --tags
	git remote rm origin
	git push $NAME master
	git remote rename $NAME origin
}
