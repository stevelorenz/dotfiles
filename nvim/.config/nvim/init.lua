-- [[
-- About: Zuo's init.lua for Neovim (v0.7.0).
--        Neovim is currently my daily driver for software development (I work as a software engineer) and text writing.
--        All configurations are made for my PERSONAL workflows.
--
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- ]]

local vim = vim

vim.cmd([[
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
" }
]])

-- The "plugin" must be firstly loaded
require("plugins")

require("autocommands")
require("colorschemes")
require("keymaps")
require("options")
