#!/usr/bin/env bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" || exit
    pwd -P
)"
DFPATH=$(realpath "$SCRIPTPATH/../")

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\033[32m[✔]\033[0m ${1}${2}"
    fi
}

warning() {
    msg "\033[33mWarning:\033[0m ${1}${2}"
}

error() {
    msg "\033[31m[✘]\033[0m ${1}${2}"
    exit 1
}

lnif() {
    if [ -e "$1" ]; then
        ln -sfn "$1" "$2"
    fi
}

# Deploy dotfiles
function deploy_dotfiles() {

    declare src_dir="$1" dst_dirs="$2" dotfiles="$3" name="$4" add_dot="$5"

    for dst_dir in $dst_dirs; do
        mkdir -p "$dst_dir"
        for file in $dotfiles; do
            dst_file=$file
            if [[ $add_dot == 1 ]]; then
                msg "Prepend dot to the destination file name"
                dst_file=".$dst_file"
                msg "Destination file name: $dst_file"
            fi
            if [[ -e "$dst_dir/$dst_file" ]]; then
                warning "$dst_file already exits in $dst_dir. Are you sure to overwrite it? ([y]/n)"
                read -r -n 1
                if [[ ! $REPLY ]] || [[ $REPLY =~ ^[Yy]$ ]]; then
                    lnif "$src_dir/$file" "$dst_dir/$dst_file"
                fi
            else
                ln -sn "$src_dir/$file" "$dst_dir/$dst_file"
            fi
        done
    done
    ret="$?"
    success "$name dotfiles have been deployed."
}

# *** Dotfiles deployed in $HOME directory
msg "Deploy BASH RC files"
src_dir="$DFPATH/shell/bash"
deploy_dotfiles "$src_dir" "$HOME" "bashrc" "BASH RCs" 1

msg "Deploy ZSH RC files"
src_dir="$DFPATH/shell/zsh"
deploy_dotfiles "$src_dir" "$HOME" "zshrc zshenv" "ZSH RCs" 1

# *** Tool with multiple dotfiles
msg "Deploy VIM/NeoVIM dotfiles"
src_dir=$(realpath "$SCRIPTPATH/../vim")
dst_dirs="$HOME/.vim $HOME/.config/nvim"
dotfiles="vimrc.vim plugin.vim after colors custom_snippets ftplugin vimrc_tiny.vim init.vim"
name="VIM/NeoVIM"
deploy_dotfiles "$src_dir" "$dst_dirs" "$dotfiles" "$name" 0
ln -sf "$HOME/.vim/vimrc_tiny.vim" "$HOME/.vimrc"

msg "Deploy Polybar dotfiles"
src_dir=$(realpath "$SCRIPTPATH/../polybar")
dst_dir="$HOME/.config/polybar"
dotfiles="config launch.sh"
name="Polybar"
deploy_dotfiles "$src_dir" "$dst_dir" "$dotfiles" "$name" 0

# *** Loop over tool with single file dotfile
names="I3WM Termite Zathura Alacritty Ranger"
src_dirs="$DFPATH/i3 $DFPATH/termite $DFPATH/zathura $DFPATH/alacritty $DFPATH/ranger"
dst_dirs="$HOME/.config/i3 $HOME/.config/termite $HOME/.config/zathura/ $HOME/.config/alacritty $HOME/.config/ranger"
dotfiles="config config zathurarc alacritty.yml rc.conf"
names_arr=($names)
src_dirs_arr=($src_dirs)
dst_dirs_arr=($dst_dirs)
dotfiles_arr=($dotfiles)

for ((i = 0; i < ${#names_arr[@]}; i++)); do
    msg "Deploy ${names_arr[$i]} dotfile"
    deploy_dotfiles "${src_dirs_arr[$i]}" "${dst_dirs_arr[$i]}" "${dotfiles_arr[$i]}" "${names_arr[$i]}" 0
done
