#!/bin/sh
#
# set iterm2 settings
if [ -z $(defaults read com.googlecode.iterm2.plist PrefsCustomFolder) ]; then
    echo -e "\033[1;33m› Pointing iterm2 settings to use custom dotfiles settings..\033[0m"
    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
else
    echo -e "\033[1;33m› iterm2 custom settings already exist, skipping step..\033[0m"
fi