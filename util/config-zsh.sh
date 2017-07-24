#!/bin/bash
#
# About: Install and config ZSH
#
# config-tools.sh
# Copyright (C) 2017 steve <steve@steve-pc>

DOTFILES_DIR="$HOME/.cache/dotfiles"
CUR_DATE=$(date +%Y-%m-%d)

if ! type git > /dev/null; then
    printf "[Warning] Git is not installed, please install git.\n"
    exit 1
fi

OS=$(lsb_release -si)

case $OS in
    'ManjaroLinux' )
        echo "ManjaroLinux detected."
        INSTALL='pacman -S'
        ;;
esac

echo "Install ZSH..."

sudo "$INSTALL" zsh

echo "Clone and install Oh-My-ZSH..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

if [[ -d "$DOTFILES_DIR" ]]; then
    printf "[Warning] The dotfiles directory exists in the ~/.cache/ \n"
    read -n1 -p -r "Do you want to (b)ackup it, (r)emove it or doing (n)othing? (b/r/n) " choice
    printf "\n"
    case $choice in
        b)
            printf "Backup the dotfile folder...\n"
            cp "$HOME/.cache/dotfiles/" "$HOME/.cache/dotfiles_backup_$CUR_DATE"
            rm -rf "$DOTFILES_DIR"
            ;;
        r)
            printf "Remove the dotfile folder...\n"
            rm -rf "$DOTFILES_DIR"
            ;;
        n)
            printf "The script exists...\n"
            exit
            ;;
    esac
fi

echo "Clone ZSH config files..."
cp -f "$DOTFILES_DIR/shell/zsh/zshrc" ~/.zshrc
cp -f "$DOTFILES_DIR/shell/zsh/zshenv" ~/.zshenv

echo "Copy custom aliases..."
cp -f "$DOTFILES_DIR/shell/custom_aliases.sh" ~/.custom_aliases.sh

echo "Install ZSH completions plugin..."
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

echo "Install ZSH autosuggestion plugin..."
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
