" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"==========================================
" About: Zuo's Configuration File for Neovim
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
" Initial Plugin: Vim-Plug
"==========================================
" {

" Use curl to get plug.vim if not exists
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" enable syntax highlighting
syntax enable
syntax on

" load plugins and configurations in ./plugin.vim
let plugrc = stdpath('config') . '/plugin.vim'
" expand("~/.config/nvim/plugin.vim")
if filereadable(plugrc)
    :execute 'source '.fnameescape(plugrc)
endif

" enable file type, plugin and indent detection
filetype plugin indent on
" }

"==========================================
" General Settings
"==========================================
" {
" set vim history in .viminfo
set history=10000

" auto read file after editing
set autoread

" close backup file
set nobackup
set nowb
set noswapfile

" correct backspace
set backspace=eol,start,indent

" enable mouse and hide mouse while typing
set mouse=a
set mousehide

" for regular expressions turn magic on
set magic

" change the terminal's title
set title

" close error bell
set novisualbell " don't beep
set noerrorbells " don't beep
set t_vb=
set tm=500

" restore cursor position when opening file
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" default folding settings
set foldenable
set foldmethod=indent
set foldlevel=99
set nofoldenable  " do not fold by opening file

" allow switching buffer without saving
set hidden

" tab indent default settings
set noexpandtab
set tabstop=4      " noc (number of columns) of each tab
set shiftwidth=4   " noc for re-indent operations
set softtabstop=4  " noc for tapping tab key
" if softtabstop=12 and tabstop=8 then a tab key will converted into one tab and 4 whitespaces
set smarttab       " insert tabs on the start of a line according to shiftwidth, not tabstop
set shiftround     " use multiple of shift width when indenting with '<' and '>'
set autoindent     " indent at the same level of the previous line

" use single line to show the completion in command line
set wildmenu

" searching settings
set hlsearch  " highlight results
" searching when you type the first character of the search string.
set incsearch
" ignore case if search pattern is all lowercase, case-sensitive otherwise
set ignorecase
set smartcase

" persistent undos
set undofile
set undolevels=1000      " maximum number of changes that can be undone
set undoreload=10000     " maximum number lines to save for undo on a buffer reload

" new splits
set splitright " puts new vsplit windows to the right of the current
set splitbelow " puts new split windows to the bottom of the current

" cursor can be positioned where there is no actual character
set virtualedit=all

" automatically write a file when leaving a modified buffer
set autowrite

" always report changed lines
set report=0

" use system clipboard by default
set clipboard+=unnamedplus
" }

"==========================================
" Display Settings
"==========================================
" {

" Show as much as possible of the last line
set display=lastline

" stop cursor blinking
set gcr=a:block-blinkon0

" show line number, ruler
set number
set ruler

"default stop line breaking
set nowrap
" disable long line auto broken
set tw=0

set showcmd  " show command in normal mode
set showmode  " show vim mode
set tabpagemax=15  " only show 15 tabs

" number of showed lines by scrolling
set scrolloff=8

" highlight matching delimiter
set showmatch

" how many tenths of a second to blink when matching brackets
set matchtime=5

" highlight current row and column
set cursorline
set cursorcolumn

" highlighting some specific characters
if has("autocmd")
    " highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\|ISSUE\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|MARK\|NOTICE\)')
    endif
endif

" relative line number in normal mode
" absolute line number in insert mode
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" use dark background
set background=dark
set termguicolors
colorscheme onedark

set colorcolumn=120

" always show the sign column
set signcolumn=yes
" signcolumn should match background
highlight clear SignColumn

" show invisible characters
set list
" display extra whitespace
set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" always show tabline
set showtabline=2

" avoid the pop up menu occupying the whole screen
set pumheight=20
" }

"==========================================
" File General Settings
"==========================================
" {
" default coding
set encoding=utf-8
set fileencoding=utf-8
" alternative list of encodings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set emoji

" help texts
set helplang=en
set termencoding=utf-8

" use unix as the default file type
set fileformats=unix,dos,mac
" }

"==========================================
" Keyboard Mapping Settings
"==========================================
" {
" set leader key to space
let mapleader = " "
let g:mapleader = " "

" map ; to :
nnoremap ; :

nnoremap <leader>q :q<CR>

" tap jk quickly to normal mode
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" use system clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" change window size
" horizontal: = -
" vertical: , .
nnoremap w=  :resize +3<CR>
nnoremap w-  :resize -3<CR>
nnoremap w,  :vertical resize -3<CR>
nnoremap w.  :vertical resize +3<CR>

" show searching results at middle of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" toggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" move lines
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" ctrl+s for update: save the file
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s> :update<cr>

" open/close quickfix/location window
noremap <leader>c :copen<cr>
noremap <leader><leader>c :cclose<bar>lclose<cr>

" fuzzy finder for files
noremap <leader>f :Clap files<cr>

" === Tab and Buffer===
" --- Buffer---
" switch buffer
noremap <C-left> :bprevious<CR>
noremap <C-right> :bnext<CR>
" close the current buffer
nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT
" close all buffers
nnoremap <leader>ba :bufdo bd<cr>

" === F1 - F10 ===
" F1: avoid to open help info
nnoremap <F1> :echo<CR>
inoremap <F1> <C-o>:echo<CR>

" F3: toggle syntax highlight
nnoremap <F3> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" F5: Hide everything to have a presentation mode.
nnoremap <F5> : set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>

" F6: Open nerdtree file explorer
nnoremap <F6> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" F7: Open vim-clap
nnoremap <F7> :Clap<CR>

" F8: toggle undo tree visualizer
nnoremap <F8> :UndotreeToggle<CR>

" F9: list available snippets
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
" Neovim Specific
"==========================================
" {
" disable Python2 support, use python3
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
