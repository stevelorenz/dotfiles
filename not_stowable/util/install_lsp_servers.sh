#!/bin/bash
#
# About: Install Language Server Protocol (LSP) servers for my main PLs
#        I use LSP for (new) languages without mature development libraries.
#

echo "**** Install rust-rls for Rust development"
rustup update
rustup component add rls rust-analysis rust-src

echo "*** Install gopls for GO development"
go get -u golang.org/x/tools/gopls
