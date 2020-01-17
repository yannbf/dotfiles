#!/bin/sh

echo "Setting up your Mac 🛠 🏗"

echo "Install Apple command line tools..."
# untested
check="$(xcode-\select --install)"
echo "$check"
str="xcode-select: note: install requested for command line developer tools\n"
while [[ "$check" == "$str" ]]; do
    check="$(xcode-\select --install)"
    sleep 1
done

if [[ ! -d "$HOME/.dotfiles" ]]; then
    echo "clone repo"
    git clone https://github.com/yannbf/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    script/bootstrap
else
    echo "~/.dotfiles already exists.."
fi
