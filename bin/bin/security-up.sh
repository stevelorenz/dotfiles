#!/bin/bash
#
# security-up.sh
#
# About: Setup some security-oriented configuration on a GNU/Linux desktop
#        It is assumed that all required tools are already installed.
#

VERSION=0.1

# --- Colored Output  ----------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# --- Function Definition ------------------------------------------

# printf "${GREEN} [AppArmor] ${NC} Configure AppArmor\n"


# --- Sandboxing ---
function setup_firejail() {
	printf "${GREEN} --- [Firejail] ${NC} Configure Firejail.\n"
	cp /etc/firejail/*.profile ~/.config/firejail/
}

setup_firejail
