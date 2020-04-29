#!/bin/sh
#
# Homebrew
#
# This updates/installs all aplications from the Brewfile.

echo -e "\033[1;33m› Installing all applications from the Brewfile..\033[0m"
brew bundle --file=$HOME/.dotfiles/homebrew/Brewfile

echo -e "\033[1;33m› Install/update your app store applications from your HomebrewAppStore file? This process might take a long time."
read REPLY\?"You can install later by running update-brew (y/n) "
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo -e "\033[1;33m› Installing all applications from the Brewfile..\033[0m"
  brew bundle --file=$HOME/.dotfiles/homebrew/BrewfileAppStore
fi