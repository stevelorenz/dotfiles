" vim: foldmarker={,} foldlevel=0 foldmethod=marker:
" fold vimrc with marker {}
"==========================================
" About: Config File for Vim
" Maintainer: Xiang, Zuo
" Email: xianglinks@gmail.com
" Sections:
"    -> Initial Plugin
"    -> General Settings
"    -> Display Settings
"    -> File Encode Settings
"    -> Keyboard Mapping Settings
"    -> File Type Settings
"    -> Others
"    -> Theme Settings
"    -> Helper Functions
"==========================================


"==========================================
" Initial Plugin: Vim-Plug
"==========================================
" {
" turn off compatible mode to vi
set nocompatible

" use curl to get plug.vim if not exists
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" enable syntax highlighting
syntax enable
syntax on

" load plugins and configurations
" ! comment this part to disable all plugins
if filereadable(expand("~/.vim/plugin.vim"))
  source ~/.vim/plugin.vim
endif

" enable file type, plugin and indent detection
filetype plugin indent on
" }

"==========================================
" General Settings
"==========================================
" {
" set vim history in .viminfo
set history=2000

" auto read file after editing
set autoread

" close backup file
set nobackup
set nowb
set noswapfile

" no uganda
set shortmess=atI

" correct backspace
set backspace=eol,start,indent

" auto wrap to following lines
set whichwrap+=<,>,h,l

" show contents on screen after exit
set t_ti= t_te=

" to fix vim-multicurse selection bug
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
  set tabstop=2      " noc (number of columns) of each tab
  set shiftwidth=2   " noc for re-indent operations
  set softtabstop=2  " noc for tapping tab key, like if softtabstop=12 and tabstop=8
                     " then a tab key will converted into one tab and 4 whitespaces
  set smarttab       " insert tabs on the start of a line according to shiftwidth, not tabstop
  set expandtab      " convert tab to whitespace, using ctrl-v for real tab
  set shiftround     " use multiple of shift width when indenting with '<' and '>'
  set autoindent

" enable build-in auto completion with omnifunc
set omnifunc=syntaxcomplete#Complete

" disable the annoying preview window
set completeopt-=preview

" completion pop-up menu enhancement
" use IDE like popping
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

" set time in ms to wait for a mapping to complete
" e.g. (ctrl + F + n), the wait time after enter ctrl + f is set with ttimeoutlen
set ttimeout
set ttimeoutlen=100

" delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" :w!! sudo saves the file (useful for handling the permission-denied error)
cmap w!! w !sudo tee % > /dev/null

" don't redraw while executing macros (good performance config)
set lazyredraw

" visual mode pressing * or # searches for the current selection
" super useful! from an idea by michael naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" better swap, backup, undo and info storage
set directory=~/.vim/dirs/tmp
set backupdir=~/.vim/dirs/backups
" persistent undos
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif
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

" highlighting trailing whitespace
match ErrorMsg '\s\+$'

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
" alternative list of encodings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" help texts
set helplang=en
set termencoding=utf-8

" use unix as the default file type
set ffs=unix,dos,mac
set formatoptions+=m
" }

"==========================================
" Keyboard Mapping Settings
"==========================================
" {
" set leader key
let mapleader = ","
let g:mapleader = ","

" map ; to :
nnoremap ; :

" save and exit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" map <space> for searching
noremap <space> /

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

" mimic emacs line editing in insert mode
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <C-K> <Esc>lDa
inoremap <C-U> <Esc>d0xi
inoremap <C-Y> <Esc>Pa
inoremap <C-X><C-S> <Esc>:w<CR>a

" command line shortcut, emacs like
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" use system clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" select all in visual mode
nnoremap <leader>sa ggVG"

" copy all to system clipboard
nnoremap <leader><leader>ca :%y+<CR>

" use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

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

" add empty lines
" i.e. use 5[<space> to add 5 empty lines above current line
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" toggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" === Tab and Buffer===
" ---------------------------------------------------------
" --- Buffer---
  " list all buffers
  nnoremap <leader>l :ls<CR>
  " switch buffer
  nnoremap [b :bprevious<CR>
  nnoremap ]b :bnext<CR>
  noremap <left> :bprevious<CR>
  noremap <right> :bnext<CR>
  nnoremap ]B :blast<CR>
  nnoremap [B :bfirst<CR>
  " close the current buffer
  nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT
  " close all buffers
  nnoremap <leader>ba :bufdo bd<cr>

  " quick switching with buffer number
  nnoremap <leader>1 :b 1<CR>
  nnoremap <leader>2 :b 2<CR>
  nnoremap <leader>3 :b 3<CR>
  nnoremap <leader>4 :b 4<CR>
  nnoremap <leader>5 :b 5<CR>
  nnoremap <leader>6 :b 6<CR>
  nnoremap <leader>7 :b 7<CR>
  nnoremap <leader>8 :b 8<CR>
  nnoremap <leader>9 :b 9<CR>

" --- Tab ---
  nnoremap <leader>th :tabfirst<cr>
  nnoremap <leader>tl :tablast<cr>
  nnoremap <leader>tj :tabnext<cr>
  nnoremap <leader>tk :tabprev<cr>
  nnoremap <leader>tn :tabnext<cr>
  nnoremap <leader>tp :tabprev<cr>
  nnoremap <leader>te :tabedit<cr>
  nnoremap <leader>td :tabclose<cr>
  nnoremap <leader>tm :tabm<cr>
" ---------------------------------------------------------

" === F1 - F10 ===
" ---------------------------------------------------------
" F1: avoid to open help info
nnoremap <F1> :echo<CR>
inoremap <F1> <C-o>:echo<CR>

" F2: toggle line number
nnoremap <F2> :call HideNumber()<CR>

" F3: toggle syntax highlight
nnoremap <F3> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" F8: toggle undo tree visualizer
nnoremap <F8> :UndotreeToggle<CR>

" F10: toggle tagbar
nnoremap <F10> :TagbarToggle<CR>
" ---------------------------------------------------------
" }

"==========================================
" File Type Custom Settings
"==========================================
" {
  " -- c/cpp --
  autocmd FileType *.c, *.cpp, *.h, *.hpp
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4 |

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
      \ set tabstop=2 |
      \ set shiftwidth=2 |
      \ set softtabstop=2 |

  " -- python --
  autocmd BufNewFile,BufRead *.py
      \ set filetype=python |
      \ set textwidth=120 |
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ ab ip import ipdb; ipdb.set_trace() |

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
" use dark background
set background=dark
" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
  let &t_Co = 256
  colorscheme wombat256i
else
  colorscheme wombat256mod
endif

" --- GUI ---
if has('gui_running')
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
endif

" fix highlight problem
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
" }

"==========================================
" Helper Functions
"==========================================
" {
" === General ===
" {
" toggle line number type
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc

" hide line number
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

" removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" selection in visual mode
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" h, hpp header file add gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction

" don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
" }
" }
