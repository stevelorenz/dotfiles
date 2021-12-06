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
" If plug.vim does not exist in the standard data path, curl is used to get it.
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
" General Settings
"==========================================
" {
" No backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Enable mouse and hide mouse while typing
set mouse=a
set mousehide

" Restore the cursor position when opening file
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Form folds with indent
set foldmethod=indent
" Dot not form folds when opening the file
set nofoldenable

" Allow switching buffer without saving
set hidden

" Tab indent settings
" if softtabstop=12 and tabstop=8 then a tab key will converted into one tab and 4 whitespaces
set noexpandtab
set tabstop=4      " noc (number of columns) of each tab
set shiftwidth=4   " noc for re-indent operations
set softtabstop=4  " noc for tapping tab key

" Searching settings
set ignorecase
set smartcase

" Save undo history to persistent files
set undofile

" For new splits
set splitright
set splitbelow

" Cursor can be positioned where there is no actual character
set virtualedit=all

" Always report changed lines
set report=0

" Use system clipboard by default
set clipboard+=unnamedplus
" }

"==========================================
" Display Settings
"==========================================
" {
" Show line number
set number

" Do not auto wrap the line when it is longer than the width of the window.
set nowrap

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=999

" Highlight current row and column
set cursorline
set cursorcolumn

" Relative line number in normal mode, absolute line number in insert mode
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" Use dark background
set background=dark
set termguicolors
colorscheme onedark

" Show screen column
set colorcolumn=120

" Always show the sign column
set signcolumn=yes
highlight clear SignColumn

" Show some invisible characters
set list
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" Always show tabline
set showtabline=2

" Avoid the pop up menu occupying the whole screen
set pumheight=20
" }

"==========================================
" File General Settings
"==========================================
" {
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set emoji

set helplang=en
set termencoding=utf-8

" Use unix as the default file type
set fileformats=unix,dos,mac
" }

"==========================================
" Keyboard Mapping Settings
"==========================================
" {
" Set global leader key to space
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" For quicker :
nnoremap ; :

" Type jk quickly and enter normal mode
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Use system clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" Treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Change window size
" horizontal: = -
" vertical: , .
nnoremap w=  :resize +3<CR>
nnoremap w-  :resize -3<CR>
nnoremap w,  :vertical resize -3<CR>
nnoremap w.  :vertical resize +3<CR>

" Show searching results at middle of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Toggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" Jump between tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" Ctrl+s for update: save the file
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>

" Open/close quickfix/location window
noremap <leader>c :copen<cr>

" Fuzzy finder for files
noremap <leader>f :Clap files<cr>

" === Tab and Buffer ===
" switch buffer
noremap <C-left> :bprevious<CR>
noremap <C-right> :bnext<CR>
" close (or delete) the current buffer
nnoremap <leader>bd :bp <BAR> bd #<CR>
" show all open buffers and their status
nnoremap <leader>bl :ls<CR>

" === F1 - F10 ===
" F1: avoid to open help info
nnoremap <F1> :echo<CR>
inoremap <F1> <C-o>:echo<CR>

" F2: TODO

" F3: TODO
"
" F4: TODO

" F5: TODO

" F6: TODO

" F7: Open vim-clap
nnoremap <F7> :Clap<CR>

" F8: toggle undo tree visualizer
nnoremap <F8> :UndotreeToggle<CR>

" F9: list available snippets, used by UltiSnips by default
" > Check config of UltiSnips in plugin.vim

" F10: toggle vista (Tag/Symbols viewer)
nnoremap <F10> :Vista!!<CR>
" }

"==========================================
" File Type Custom Settings
"==========================================
" {
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hh,*.hpp,*.cc,*.cxx
            \ set foldmethod=syntax |

autocmd BufNewFile,BufRead *.ini,*.conf,*.cfg
            \ set filetype=dosini |
            \ set spell |

autocmd BufNewFile,BufRead *.tex
            \ set filetype=tex |
            \ set spell |

autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
            \ set filetype=markdown |
            \ set spell |

autocmd BufNewFile,BufRead *.py
            \ set expandtab |

autocmd BufNewFile,BufRead meson.build
            \ set expandtab |
" }

"==========================================
" Providers
"==========================================
" {
" Disable Python 2 support, use the system Python 3 interpreter
let g:loaded_python_provider = 0
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
" }

"==========================================
" Helper Functions
"==========================================
" {
" removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
" }
