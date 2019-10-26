#!/bin/bash
#
# About: Install Language Server Protocol (LSP) servers for my main PLs
#

echo "* Install rust-rls for Rust development"
rustup update
rustup component add rls rust-analysis rust-src

echo "* Install gopls for GO development"
go get golang.org/x/tools/gopls
