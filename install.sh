#!/bin/bash

TARGET="$HOME/.bash_config"
RELOAD_PROMPT=""

wget https://github.com/jasonwarta/.bash_config/archive/master.zip -O ~/Downloads/bash_config.zip &&
unzip $HOME/Downloads/bash_config.zip -d $HOME/Downloads/bash_config &&
mv $HOME/Downloads/bash_config/.bash_config-master $TARGET &&
rm -r $HOME/Downloads/bash_config $HOME/Downloads/bash_config.zip &&
mkdir -p $TARGET/local_settings &&
touch $TARGET/local_settings/{path.sh,aliases.sh,functions.sh} && 
if [ -r $HOME/.bashrc ]; then
    echo -e "\n. $TARGET/index.sh" >> $HOME/.bashrc
    RELOAD_PROMPT=" or run 'source $HOME/.bashrc'"
elif [ -r $HOME/.profile ]; then
    echo ie "\n. $TARGET/index.sh" >> $HOME/.profile
    RELOAD_PROMPT=" or run 'source $HOME/.profile'"
else
    echo "Add '. "$TARGET"/index.sh' to the end of your bash profile."
fi &&
echo -e "\nRelaunch your terminal$RELOAD_PROMPT to apply changes."
