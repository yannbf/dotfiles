#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles.."

    git clone --depth=1 https://github.com/yannbf/dotfiles.git "$HOME/.doftiles"
    cd "$HOME/.dotfiles"
    script/bootstrap
else
    echo "The doftiles are already installed!"
fi