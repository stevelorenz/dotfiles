#!/bin/bash
# Install tools and related plugins
#
#
# Author : Zuo Xiang
# Email  : xianglinks@gmail.com
#
# TODOs:
#   * Better checking for distros, current just for ubuntu and arch.

####################
#  Help Functions  #
####################

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

have_program() {
  [ -x "$(which $1)" ]
}

install_tmux_plugins() {
  if [[ -d ~/.tmux && ! -d ~/.tmux/plugins ]]; then
    info 'Installing tpm (tmux plugin manager)'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    success 'Tmux plugin manager is installed'
  else
    info 'Tmux plugin manager is already installed.'
  fi
}

install_vim8() {
  if have_program apt-get ; then
    info 'Install vim 8.0 via PPA'
    sudo apt-get -y install software-properties-common
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt-get update
    sudo apt-get -y install vim
    success 'Vim 8.0 is installed.'
  fi
}

install_neovim() {
  # For ubuntu with apt, install with PPA
  if have_program apt-get ; then
    info 'Install neovim via PPA'
    sudo apt-get -y install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get -y install neovim
    success 'Neovim is installed.'
  # Use pacman for Arch based distro
  elif have_program pacman ; then
    info 'Install neovim via pacman'
    sudo pacman -S neovim
    success 'Neovim is installed.'
  else
    fail 'Install failed, unknown package manager.'
  fi
}

################
#  Basic Menu  #
################

info 'All tools will be installed with distro package manager or by cloning codes with git.'
info 'There is no manual building and configuration operations.'

PS3='Please choose the tool to be installed: '

options=("Tmux plugin manager"
         "Vim 8.0"
         "Neovim"
         "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Tmux plugin manager")
            install_tmux_plugins
            break
            ;;
        "Vim 8.0")
            install_vim8
            break
            ;;
        "Neovim")
            install_neovim
            break
            ;;
        "Quit")
            break
            ;;
        *) fail 'Invalid option';;
    esac
done
