" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"==========================================
" About: Zuo's Configuration File for NeoVIM
"        NeoVIM is currently my daily driver for development and writing
"        All configurations are made for my PERSONAL workflow
"
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
" TODO: Consider MIGRATING to init.lua.
" Embed lua << EOF in *.vim files does not work nicely for multiple files...
" Lua's syntax and development are easier for me compared to vimscript
" Currently I'm busy for PhD thesis, so should look into this later...
"==========================================

execute 'source' fnamemodify(expand('<sfile>'), ':p:h').'/vimrc.vim'
