#!/bin/sh
#
# Homebrew
#
# This updates/installs all aplications from the Brewfile.

echo -e "\033[1;33m› Installing all applications from the Brewfile..\033[0m"
brew bundle --file=$HOME/.dotfiles/homebrew/Brewfile