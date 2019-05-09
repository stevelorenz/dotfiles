#!/bin/bash
#
# About: Configure of my most used tools
#

DOTFILES_DIR="$HOME/.cache/dotfiles"
CUR_DATE=$(date +%Y-%m-%d)

if ! type git > /dev/null; then
    printf "[Warning] Git is not installed, please install git.\n"
    exit 1
fi

if [[ -d "$DOTFILES_DIR" ]]; then
    printf "[Warning] The dotfiles directory exists in the ~/.cache/ \n"
    read -p "Do you want to (b)ackup it, (r)emove it or doing (n)othing? " choice
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
            printf "Doing nothing...\n"
            ;;
    esac
fi

mkdir -p "$DOTFILES_DIR"
git clone https://github.com/stevelorenz/dotfiles.git "$DOTFILES_DIR"

VIMDIR="$HOME/.vim"
NVIMDIR="$HOME/.config/nvim"
TMUXDIR="$HOME/.tmux"

mkdir -p $VIMDIR
mkdir -p $NVIMDIR
mkdir -p $TMUXDIR

printf "\n[Config] Copy and link vim config...\n"
if [[ -d  "$VIMDIR" ]]; then
    printf "[Warning] vim config dir already exists, rename it to ~/.vim_%s\n" "$CUR_DATE"
    mv "$HOME/.vim" "$HOME/.vim_$CUR_DATE"
fi
cp -r "$DOTFILES_DIR/vim" "$HOME/.vim"
ln -sf "$HOME/.vim/vimrc.vim" "$HOME/.vimrc"

printf "\n[Config] Copy neovim config...\n"
if [[ -d  "$NVIMDIR" ]]; then
    printf "[Warning] neovim config dir already exists, rename it to ~/.config/nvim_%s\n" "$CUR_DATE"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim_$CUR_DATE"
fi
cp -r "$DOTFILES_DIR/vim" "$HOME/.config/nvim"

printf "\n[Config] Copy and link tmux config...\n"
if [[ -d  "$TMUXDIR" ]]; then
    printf "[Warning] tmux dir already exists, rename it to ~/.tmux_%s\n" "$CUR_DATE"
    mv "$HOME/.tmux" "$HOME/.tmux_$CUR_DATE"
fi
cp -r "$DOTFILES_DIR/tmux" "$HOME/.tmux"
ln -sf "$HOME/.tmux/tmux.conf" "$HOME/.tmux.conf"

printf "\n[Config] Copy common dev config files...\n"
cp -f "$DOTFILES_DIR/dev_tool/agignore" "$HOME/.agignore"
cp -f "$DOTFILES_DIR/dev_tool/ctags" "$HOME/.ctags"
cp -f "$DOTFILES_DIR/dev_tool/gdbinit" "$HOME/.gdbinit"
mkdir -p "$HOME/.config/pip"
cp -f "$DOTFILES_DIR/dev_tool/python_dev/pip.conf" "$HOME/.config/pip/pip.conf"
mkdir -p "$HOME/.config/cmus"
cp -rfT "$DOTFILES_DIR/cmus" "$HOME/.config/cmus"
cp -f "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

printf "[CLEANUP] Remove dotfile directory.\n"
rm -rf "$DOTFILES_DIR"
