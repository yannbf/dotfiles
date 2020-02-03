#!/bin/sh
#
if type "yarn" > /dev/null; then
  if [ -d $HOME/.config ]; then
    echo "\033[1;33m› Adding permission to .config folder(necessary for git, yarn, etc)..\033[0m"
    sudo chown -R $USER:$GROUP $HOME/.config
  else 
    echo "\033[1;33m› .config folder does not exist, please run ./dotfiles/yarn/install later!\033[0m"
  fi
fi