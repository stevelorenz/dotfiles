" vim: foldmarker={,} foldlevel=0 foldmethod=marker:
" fold vimrc with marker {}
"==========================================
" About:  Init File for NeoVim
" Author: Xiang, Zuo
" Email:  xianglinks@gmail.com
" Sections:
"     # General Settings
"     # Display Settings
"     # File Encode Settings
"     # Keyboard Settings
"     # File Type Settings
"     # Others
"     # Theme Settings
"==========================================

"==========================================
" General Settings
"==========================================
" {
" turn off compatible mode to vi
set nocompatible

" enable syntax highlighting
syntax enable
syntax on

" enable filetype, plugin and indent detection
filetype plugin indent on
" }

" set vim history in .viminfo
set history=2000

" autoread file after editing
set autoread

" close backup file
set nobackup
set noswapfile
" no Uganda
set shortmess=atI

" correct backspace
set backspace=eol,start,indent
" auto wrap to following lines
set whichwrap+=<,>,h,l

" show contents on screen after exit
set t_ti= t_te=

" fix vim-multicurse selection bug
" the character under cursor will also be selected
set selection=inclusive
set selectmode=key

" disable and hide mouse
set mouse-=a
set mousehide

" for regular expressions turn magic on
set magic

" change the terminal's title
set title

" close error bell
set novisualbell         " don't beep
set noerrorbells         " don't beep
set t_vb=
set tm=500

" restore cursor position when opening file
" based on .viminfo file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" default folding settings
set foldenable
  " manual
  " indent
  " expr
  " syntax
  " diff
  " marker
set foldmethod=indent
set foldlevel=99
set nofoldenable  " do not fold by opening file

" allow switching buffer without saving
set hidden

" tab indent default settings
  set tabstop=2      " noc (number of columns) for each tab
  set shiftwidth=2   " noc for using ident command
  set softtabstop=2  " noc for each tapping tab
  set smarttab       " insert tabs on the start of a line according to shiftwidth, not tabstop
  set expandtab      " convert tab to whitespace, using ctrl-v for real tab
  set shiftround     " use multiple of shiftwidth when indenting with '<' and '>'
  set autoindent

" enable build-in autocompletion, omnifunc
set omnifunc=syntaxcomplete#Complete
" disable preview window
set completeopt-=preview
set completeopt=longest,menu

" use single line to show the completion in command line
set wildmenu

" searching settings
  set hlsearch  " highlight results
  " searching when you type the first character of the search string.
  set incsearch
  " ignore case if search pattern is all lowercase, case-sensitive otherwise
  set ignorecase
  set smartcase

" }

"==========================================
" Display Settings
"==========================================
" {
" stop cursor blinking
set gcr=a:block-blinkon0

" show line number, ruler
set number
set ruler
"default stop line breaking
set nowrap

set showcmd  " show command in normal mode
set showmode  " show vim mode

" number of showed lines by scrolling
set scrolloff=8

" highlight matching delimiter
set showmatch

" how many tenths of a second to blink when matching brackets
set matchtime=2

" always show the status line - use 2 lines for the status bar
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2

" highlight current row and column
set cursorline
set cursorcolumn

" highlighting trailing whitespaces
match ErrorMsg '\s\+$'

" removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" highlighting some specific characters
if has("autocmd")
  " highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
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
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc

" fix vim color problem in tmux
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" }

"==========================================
" File Encode Settings
"==========================================
" {
" default coding
set encoding=utf-8
set fileencoding=utf-8
" Try following codings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" help texts
set helplang=en
set termencoding=utf-8

" use unix as the standard file type
set ffs=unix,dos,mac
set formatoptions+=m
" }

"==========================================
" Keyboard Settings
"==========================================
" {
" set leader key
let mapleader=","

" map ; to :
nnoremap ; :

" save and exit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>
" close current buffer
nmap <leader>b :bd<CR>

" map <space> for searching
map <space> /

" tap kj quickly to normal mode
inoremap kj <Esc>

" close arrow keys in insert mode
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" delete lines (not cut)
nnoremap <leader><leader>x "_dd
vnoremap <leader><leader>x "_dd

" mimic emacs line editing in insert mode only
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-K> <Esc>lDa
inoremap <C-U> <Esc>d0xi
inoremap <C-Y> <Esc>Pa
inoremap <C-X><C-S> <Esc>:w<CR>a

" command line shortcut, emaces like
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" use system clipboard
" works with xclip pkg
vnoremap <leader>y "+y
nmap <leader>p "+p

" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" select all in visual mode
map <leader>sa ggVG"
" copy all to system clipboard
map <leader><leader>ca :%y+<CR>

" dishighlight searching results
nmap <leader><leader>n :noh<CR>

" change window size
  " horizontal: = -
  " vertical: , .
nmap w=  :resize +3<CR>
nmap w-  :resize -3<CR>
nmap w,  :vertical resize -3<CR>
nmap w.  :vertical resize +3<CR>

" show searching results at middle of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" add empty lines
" i.e. use 5[<space> to add 5 empty lines above current line
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" === Tab and Buffer===
" ---------------------------------------------------------
" --- Buffer---
  nnoremap <leader>l :ls<CR>
  nnoremap [b :bprevious<cr>
  nnoremap ]b :bnext<cr>

  " arrow key switching buffer in normal mode
  noremap <left> :bp<CR>
  noremap <right> :bn<CR>

  " quick switching
  map <leader>1 :b 1<CR>
  map <leader>2 :b 2<CR>
  map <leader>3 :b 3<CR>
  map <leader>4 :b 4<CR>
  map <leader>5 :b 5<CR>
  map <leader>6 :b 6<CR>
  map <leader>7 :b 7<CR>
  map <leader>8 :b 8<CR>
  map <leader>9 :b 9<CR>

" --- Tab ---
  map <leader>th :tabfirst<cr>
  map <leader>tl :tablast<cr>

  map <leader>tj :tabnext<cr>
  map <leader>tk :tabprev<cr>
  map <leader>tn :tabnext<cr>
  map <leader>tp :tabprev<cr>

  map <leader>te :tabedit<cr>
  map <leader>td :tabclose<cr>
  map <leader>tm :tabm<cr>
" ---------------------------------------------------------

" === F1 - F10 ===
" ---------------------------------------------------------
" F1: Close help info
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

" F2: Toggle line number
nnoremap <F2> :call HideNumber()<CR>
  function! HideNumber()
    if(&relativenumber == &number)
      set relativenumber! number!
    elseif(&number)
      set number!
    else
      set relativenumber!
    endif
    set number?
  endfunc

" F3: Toggle syntax
map <F3> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>
" ---------------------------------------------------------
" }

"==========================================
" File Type Settings
"==========================================

" {
  " -- c/cpp --
  autocmd FileType *.c, *.cpp, *.h, *.hpp
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4 |

  " h, hpp header file add gates
  function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
  endfunction
  autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

  " -- haskell --
  autocmd BufNewFile,BufRead *.hs
      \ set tabstop=8 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set shiftround |

  " -- markdown --
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown
      \ set filetype=markdown.mkd |
      \ set textwidth=120 |
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4 |

  " -- python --
  autocmd BufNewFile,BufRead *.py
      \ set filetype=python |
      \ set textwidth=79 |
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |

  " -- tex --
  autocmd BufNewFile,BufRead *.tex set textwidth=120

  " -- web dev --
  autocmd BufNewFile,BufRead *.js,*.html,*.css
      \ set expandtab!

  " -- vim script --
  autocmd BufNewFile,BufRead *.vim
      \ set filetype=vim |
      \ set textwidth=120 |
" }

"==========================================
" Others
"==========================================
" {

" }

"==========================================
" Theme Settings
"==========================================
" {
" --- CLI ---
  " use terminal 256 color
  set t_Co=256
  " set color scheme
  set background=dark
  colorscheme wombat256i

" --- GUI ---
  set guifont=Monaco\ 10
  set guicursor=a:blinkon0
  set gcr=a:block-blinkon0
  " hide menu bars
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set guioptions-=m
  set guioptions-=T
  set guitablabel=%M\ %t
  set showtabline=1
  set linespace=2
  set noimd

  hi! link SignColumn   LineNr
  hi! link ShowMarksHLl DiffAdd
  hi! link ShowMarksHLu DiffChange

  " fix highlight problem
  highlight clear SpellBad
  highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
  highlight clear SpellCap
  highlight SpellCap term=underline cterm=underline
  highlight clear SpellRare
  highlight SpellRare term=underline cterm=underline
  highlight clear SpellLocal
  highlight SpellLocal term=underline cterm=underline
" }
