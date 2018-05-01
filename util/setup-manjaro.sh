#!/bin/bash
#
# About: Setup Manjaro Linux after new installation

################
#  Util Funcs  #
################

red_echo() {
    echo -e "\x1b[1;31m[E] $SELF_NAME: $MESSAGE\e[0m"
}

simple_red_echo() {
    echo -e "\x1b[1;31m$MESSAGE\e[0m"
}

green_echo() {
    echo -e "\x1b[1;32m[S] $SELF_NAME: $MESSAGE\e[0m"
}

simple_green_echo() {
    echo -e "\x1b[1;32m$MESSAGE\e[0m"
}

blue_echo() {
    echo -e "\x1b[1;34m[I] $SELF_NAME: $MESSAGE\e[0m"
}

simple_blue_echo() {
    echo -e "\x1b[1;34m$MESSAGE\e[0m"
}

#############
#  Install  #
#############

function install_latex() {
    MESSAGE="Install Latex related packages!"; green_echo
}

SELF_NAME=$(basename $0)
install_latex
