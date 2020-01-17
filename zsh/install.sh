#!/bin/sh
#
# Oh my zsh
# This script installs oh my zsh for zsh theming
if ! [ -d "$HOME/.dotfiles/.oh-my-zsh" ]; then
    echo -e "\033[1;33m› Installing oh my zsh..\033[0m"
    ZSH=$HOME/.dotfiles/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Removes .zshrc from $HOME (that OMZ creates erroniously) and symlinks the .zshrc file from the .dotfiles
    echo -e "\033[1;33m› Adjusting zsh files..\033[0m"
    rm -rf "$HOME/.zshrc"
    ln -s "$HOME/.dotfiles/zsh/zshrc.symlink" "$HOME/.zshrc"

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.dotfiles/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.dotfiles/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    
	echo -e "\033[1;33m› All done! Opening zsh..\033[0m"

	exec zsh -l
else
    echo "Oh my zsh is already installed, skipping installation.."
fi