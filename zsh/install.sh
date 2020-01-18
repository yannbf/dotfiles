#!/bin/sh
#
# Oh my zsh
# This script installs oh my zsh for zsh theming

set_shell() {
    case "$SHELL" in
    */zsh)
        if [ "$(command -v zsh)" != '/usr/local/bin/zsh' ] ; then
        update_shell
        fi
        ;;
    *)
        update_shell
        ;;
    esac
}

update_shell() {
  local shell_path;
  shell_path="$(command -v zsh)"

  echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  sudo chsh -s "$shell_path" "$USER"
}

install_ohmyzsh() {
    echo -e "\033[1;33m› Installing oh my zsh..\033[0m"
    ZSH=$HOME/.dotfiles/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # Removes .zshrc from $HOME (that OMZ creates erroniously) and symlinks the .zshrc file from the .dotfiles
    echo -e "\033[1;33m› Adjusting zsh files..\033[0m"
    rm -rf "$HOME/.zshrc"
    ln -s "$HOME/.dotfiles/zsh/zshrc.symlink" "$HOME/.zshrc"
}

install_ohmyzsh_plugins() {
    echo -e "\033[1;33m› Installing oh my zsh plugins..\033[0m"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.dotfiles/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.dotfiles/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

if ! [ -d "$HOME/.dotfiles/.oh-my-zsh" ]; then
    install_ohmyzsh
    install_ohmyzsh_plugins
    set_shell
	echo -e "\033[1;33m› All done! Opening zsh..\033[0m"
	exec zsh -l
else
    echo "Oh my zsh is already installed, skipping installation.."
fi