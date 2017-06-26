#! /bin/sh
#
# About: Set configs of my most used tools
#
# config-tools.sh
# Copyright (C) 2017 steve <steve@steve-pc>

DOTFILES_DIR="$HOME/.cache/dotfiles"
CUR_DATE=$(date +%Y-%m-%d)

if ! type git > /dev/null; then
    printf "Git is not installed, please install git.\n"
fi

if [[ -d "$DOTFILES_DIR" ]]; then
    printf "[Warning] The dotfiles directory exists in the ~/.cache/ \n"
    read -n1 -p "Do you want to (b)ackup it, (r)emove it or doing (n)othing? (b/r/n) " choice
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

mkdir -p "$DOTFILES_DIR"
git clone https://github.com/stevelorenz/dotfiles.git "$DOTFILES_DIR"

printf "\n[Config] Copy and link vim config...\n"
cp -r "$DOTFILES_DIR/vim" "$HOME/.vim"
ln -s "$HOME/.vim/vimrc.vim" "$HOME/.vimrc"

printf "\n[Config] Copy and link tmux config...\n"
cp -r "$DOTFILES_DIR/tmux" "$HOME/.tmux"
ln -s "$HOME/.tmux/tmux_no_plugins.conf" "$HOME/.tmux.conf"

##############
#  Cleanups  #
##############

rm -rf "$DOTFILES_DIR"
