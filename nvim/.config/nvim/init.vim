" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"==========================================
" About: Zuo's Configuration File for Neovim (v0.6.0)
"        Neovim is currently my daily driver for software development and text writing
"        All configurations are made for my PERSONAL workflow
"
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
"==========================================

" TODO: Consider MIGRATING to init.lua if it is the better and reasonable approach to configure Neovim.
" My setup was incrementally migrated from my old/previous vim setup that I had used for years.
" As such, it is currently not a clean or idiomatic Neovim setup.
" Currently I'm busy for PhD thesis, so would like to look into this later...

"==========================================
" Plugin Manager Settings
"==========================================
" {
" If vim-plug does not exist in the standard data path, curl is used to get it.
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plugins and configurations in ./plugin.vim
let plugrc = stdpath('config') . '/plugin.vim'
if filereadable(plugrc)
    :execute 'source '.fnameescape(plugrc)
endif
" }

"==========================================
" Lua Configuration
"==========================================
" {
" I'm now incrementally migrating vimscript configurations to lua
lua require('options')
lua require('keymaps')
lua require('colorscheme')
lua require('autocommands')
" }
