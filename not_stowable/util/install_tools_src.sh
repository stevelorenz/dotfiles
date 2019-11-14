#! /bin/bash
#
# About: Download, build and install tools from source codes
#

TMP_DIR="/tmp/_install_tools_src_root"

function make_install() {
    declare path="$1"
    cd "$path" || exit
    make
    sudo make install
}

echo "*** Install Luke's fork of the suckless simple terminal (st)."
SRC_PATH="$TMP_DIR/st"
git clone https://github.com/LukeSmithxyz/st.git "$SRC_PATH"
make_install "$SRC_PATH"

echo "*** Install Luke's build of surf brower."
SRC_PATH="$TMP_DIR/surf"
git clone https://github.com/LukeSmithxyz/surf "$SRC_PATH"
make_install "$SRC_PATH"

rm -rf "$TMP_DIR"
