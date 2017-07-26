#! /bin/bash
# About: Common functions used by other util scripts
# common-func.sh
# Copyright (C) 2017 stack <stack@comnets-desktop>

DOTFILES_REPO='https://github.com/stevelorenz/dotfiles.git'
DOTFILES_DIR="$HOME/.cache/dotfiles"
CUR_DATE=$(date +%Y-%m-%d)

function clone_dotfiles() {
    echo "[INFO] Clone dotfiles from $DOTFILES_REPO in $DOTFILES_DIR"
    if ! type git > /dev/null; then
        echo "[Warning] Git is not installed, please install git."
        exit 1
    fi

    if [[ -d "$DOTFILES_DIR" ]]; then
        echo "[Warning] The dotfiles directory exists($DOTFILES_DIR)"
        read -p "Do you want to (b)ackup it, (r)emove it or doing (n)othing? " choice
        echo
        case $choice in
            b)
                echo "Backup the dotfile folder..."
                cp "$HOME/.cache/dotfiles/" "$HOME/.cache/dotfiles_backup_$CUR_DATE"
                rm -rf "$DOTFILES_DIR"
                ;;
            r)
                echo "Remove the dotfile folder..."
                rm -rf "$DOTFILES_DIR"
                ;;
            n)
                echo "Doing nothing..."
                ;;
        esac
    fi

    echo "[CLONE] Clone dotfiles in $DOTFILES_DIR..."
    mkdir -p "$DOTFILES_DIR"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
}
