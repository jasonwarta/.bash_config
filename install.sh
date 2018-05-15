#!/bin/bash

TARGET="$HOME/.bash_config"
DOWNLOAD_LOCATION="$HOME"
RELOAD_PROMPT=""

wget https://github.com/jasonwarta/.bash_config/archive/master.zip -qO $DOWNLOAD_LOCATION/bash_config.zip &&
unzip -q $DOWNLOAD_LOCATION/bash_config.zip -d $DOWNLOAD_LOCATION/bash_config &&
if [ -d $TARGET ]; then
    mv $DOWNLOAD_LOCATION/bash_config/.bash_config-master/* $TARGET
else 
    mv $DOWNLOAD_LOCATION/bash_config/.bash_config-master $TARGET
fi &&
rm -r $DOWNLOAD_LOCATION/bash_config $DOWNLOAD_LOCATION/bash_config.zip &&
mkdir -p $TARGET/local_settings &&
touch $TARGET/local_settings/{path.sh,aliases.sh,functions.sh} && 
if [ -r $HOME/.bashrc ]; then
    if ! grep "$TARGET/index.sh" $HOME/.bashrc > /dev/null; then
        echo -e "\n. $TARGET/index.sh" >> $HOME/.bashrc
    fi
    RELOAD_PROMPT=" or run 'source $HOME/.bashrc'"
elif [ -r $HOME/.profile ]; then
    if ! grep "$TARGET/index.sh" $HOME/.profile > /dev/null; then
        echo ie "\n. $TARGET/index.sh" >> $HOME/.profile
    fi
    RELOAD_PROMPT=" or run 'source $HOME/.profile'"
else
    echo "Add '. "$TARGET"/index.sh' to the end of your bash profile."
fi &&
echo -e "\nRelaunch your terminal$RELOAD_PROMPT to apply changes."
echo -e "\nAdd any custom paths and aliases to files ending in '.sh' in '$TARGET/local_settings"
