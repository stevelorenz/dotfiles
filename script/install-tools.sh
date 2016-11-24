#!/bin/bash
# Install tools and plugins
#
#
# Author : Zuo Xiang
# Email  : xianglinks@gmail.com

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

install_tmux_plugins() {
  if [[ -d ~/.tmux && ! -d ~/.tmux/plugins ]]; then
    info 'Installing tpm (tmux plugin manager)'
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    success 'tpm install finished'
  fi
}


###################
#  Main Function  #
###################
install_tmux_plugins
