#!/bin/bash
# ------------------------------------------------------------------
# Description: Setup configuration of most used tools
# ------------------------------------------------------------------

# --- Environment --------------------------------------------------
_ME=$(basename "${0}")
VERSION=0.1.0

# --- Functions ----------------------------------------------------
function _print_help() {
    # Print the program help information.
    cat <<HEREDOC

    Usage:
    ${_ME} [--options] [<arguments>]

    Options:
    -v Config VIM with plugins.
    -h Display this help information.
HEREDOC
}

function config_vim() {
    printf "Config VIM...\n"
    if [ -d ~/dotfiles/ ]; then
        rm -rf ~/dotfiles/
    fi
    git clone https://github.com/stevelorenz/dotfiles.git ~/dotfiles
    if [ -d ~/.vim ]; then
        rm -rf ~/.vim
    fi
    cp -r ~/dotfiles/vim/ ~/.vim
    ln -s ~/.vim/vimrc.vim ~/.vimrc
}

function config_tmux() {
    printf "Config TMUX...\n"
    if [ -d ~/dotfiles/ ]; then
        rm -rf ~/dotfiles/
    fi
    git clone https://github.com/stevelorenz/dotfiles.git ~/dotfiles
    if [ -d ~/.tmux ]; then
        rm -rf ~/.tmux
    fi
    cp -r ~/dotfiles/tmux/ ~/.tmux
    ln -s ~/.tmux/tmux_no_plugins.conf ~/.tmux.conf
}

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    _print_help
    exit 1;
fi

while getopts ":vbh" optname
do
    case "$optname" in
        "v")
            config_vim
            exit 0;
            ;;
        "t")
            config_tmux
            exit 0;
            ;;
        "h")
            _print_help
            exit 0;
            ;;
        "?")
            echo "Unknown option $OPTARG"
            exit 0;
            ;;
        ":")
            echo "No argument value for option $OPTARG"
            exit 0;
            ;;
        *)
            echo "Unknown error while processing options"
            exit 0;
            ;;
    esac
done

shift $(($OPTIND - 1))
