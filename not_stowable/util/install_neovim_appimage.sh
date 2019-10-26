#!/bin/bash
#
# About: Install Neovim (Nightly release: Unstable) in AppImage format
#

cd ~/bin || exit 1
rm ./nvim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mv ./nvim.appimage ./nvim
chmod u+x nvim
