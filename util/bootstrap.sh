#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" || exit ; pwd -P )"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\033[32m[✔]\033[0m ${1}${2}"
    fi
}

warning(){
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


function deploy_vim() {
    msg "Deploy VIM/NeoVIM dotfiles."
    src_dir="$SCRIPTPATH/../vim"
    dst_dirs="$HOME/.vim $HOME/.config/nvim"
    dotfiles="vimrc.vim plugin.vim after colors custom_snippets ftplugin vimrc_tiny.vim"

    for dir in $dst_dirs; do
        for file in $dotfiles; do
            if [[ -e "$dir/$file" ]]; then
                warning "$file already exits in $dir. Are you sure to overwrite it? ([y]/n)"
                read -r -n 1;
                if [[ ! $REPLY ]] || [[ $REPLY =~ ^[Yy]$ ]]; then
                    lnif "$src_dir/$file" "$dir/$file"
                fi
            else
                ln -sn "$src_dir/$file" "$dir/$file"
            fi
        done
    done
    ln -sf "/home/zuo/.vim/vimrc.vim" "/home/zuo/.vimrc"

    ret="$?"
    success "VIM/NeoVIM dotfiles have been deployed."
}

deploy_vim
