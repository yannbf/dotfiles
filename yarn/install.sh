#!/bin/sh
#
if type "yarn" > /dev/null; then
  echo "\033[1;33m› Adding permission to .config folder(necessary for git, yarn, etc)..\033[0m"
  sudo chown -R $USER:$GROUP $HOME/.config
fi