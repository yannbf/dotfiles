#!/bin/sh
#
# Homebrew
#
# This updates/installs all aplications from the Brewfile.

ask() {
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}


echo "\033[1;33m› Installing or updating all applications from the Brewfile..\033[0m"
brew bundle --file=$HOME/.dotfiles/homebrew/Brewfile

if ask "\033[1;33m› Install/update your app store applications from your HomebrewAppStore file? This process might take a few minutes.\nYou can also install this later by running update-brew"; then
  echo "\033[1;33m› Installing all app store applications from the Brewfile..\033[0m"
  brew bundle --file=$HOME/.dotfiles/homebrew/BrewfileAppStore
fi