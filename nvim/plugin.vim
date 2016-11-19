" vim: foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About:  Plugin Configs for NeoVim
" Author: Xiang,Zuo
" Email:  xianglinks@gmail.com
"=========================================

" - Using Vim-Plug Plugin Manager -
" easy to setup, single file
" super-fast parallel installation/update
" support on-demand loading for faster startup time
"
" ------ Vim-Plug Commands ------
"     :PlugInstall     install
"     :PlugUpdate      update
"     :PlugUpgrade     upgrade
"     :PlugClean       clean

call plug#begin('~/.config/nvim/bundle')  " dir for plugin files

" -------------------- Start Config --------------------

" --- General --------------------------------------------- {

" - Statusline enhancement -
" -- vim airline --
Plug 'bling/vim-airline'
    " config symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '❯'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '❮'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'

  " config extentions
  let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1

" -- vim-airline theme repository --
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme = 'simple'

" - File system navigation -
" -- tree explorer --
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
  let NERDTreeWinSize=35
  let NERDTreeWinPos="right"
  let NERDTreeShowBookmarks=1
  let NERDTreeShowHidden=0
  let NERDTreeAutoDeleteBuffer=1  "remove buffer by cleaning file
  let NERDTreeHighlightCursorline=1
  let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
  " open file in new buffer
  let g:NERDTreeMapOpenSplit='s'
  let g:NERDTreeMapOpenVSplit='v'

  " -- tab support --
  Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeTabsToggle' }
  let g:nerdtree_tabs_open_on_console_startup=0
  let g:nerdtree_tabs_open_on_gui_startup=0

" - Insert mode auto-completion for quotes, parens, brackets -
Plug 'Raimondi/delimitMate'
  au FileType python let b:delimitMate_nesting_quotes = ['"']
  au FileType mail let b:delimitMate_expand_inside_quotes = 1

" - Fuzzy file, buffer and mru finder -
Plug 'ctrlpvim/ctrlp.vim'
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  " the dir of the current file, unless it is a subdir of the cwd
  let g:ctrlp_working_path_mode = 'a'
  let g:ctrlp_match_window_bottom = 1
  let g:ctrlp_max_height = 15
  " from bottom to top
  let g:ctrlp_match_window_reversed = 1
  " buffer of most recently used files
  let g:ctrlp_mruf_max = 500
  let g:ctrlp_follow_symlinks = 1

  " ag as backend, really faster
  " set custom ignored files here
  if executable('ag')
    " can use a .agignore at cwd to ignore some files
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -f -g ""'
  else
    "ctrl+p ignore files in .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  endif

" - Surroundings editing -
Plug 'tpope/vim-surround'

" - Enable repeating supported plugin maps with "." -
Plug 'tpope/vim-repeat'

" - Undo tree with branch support -
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
  " save history in ~/.undo
  set undofile
  set undodir=~/.undo

" - Fast cursor motion -
" -- inter lines --
Plug 'Lokaltog/vim-easymotion'
  let g:EasyMotion_smartcase = 1
  " default use one <leader> as trigger
  map  <leader>f <Plug>(easymotion-bd-f)
  nmap <leader>f <Plug>(easymotion-overwin-f)
  " <leader>s{char} to move to {char}
  " s{char}{char} to move to {char}{char}
  nmap s <Plug>(easymotion-overwin-f2)

" -- intra line --
Plug 'unblevable/quick-scope'
  " trigger a highlight only when pressing f and f.
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
  let g:qs_first_occurrence_highlight_color = '#afff5f'   " gui vim
  let g:qs_first_occurrence_highlight_color = 155         " terminal vim
  let g:qs_second_occurrence_highlight_color = '#5fffff'  " gui vim
  let g:qs_second_occurrence_highlight_color = 81         " terminal vim

" - Multiple cursor editing -
Plug 'terryma/vim-multiple-cursors'
  " use default mapping
  let g:multi_cursor_use_default_mapping=1
  " default mapping
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

" - Show marks -
Plug 'kshenoy/vim-signature'

" - Visually select increasingly larger regions of text -
Plug 'terryma/vim-expand-region'
  " default mapping
  " + expand selection
  " _ shrink selection

" - Light wrapper for ack, ag, grep etc. -
Plug 'mileszs/ack.vim'
  " do not move the cursor to the first result automatically
  cnoreabbrev Ack Ack!
  " use ag as search command if installed
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif
"  --- }


" --- General Programming --------------------------------- {

" - Collection of language packs -
Plug 'sheerun/vim-polyglot'
  " -- settings for filetypes --
  let python_highlight_all = 1
  " -- disable for some filetypes --
  " use vimtex plugin, disable latex-box
  let g:polyglot_disabled = ['latex']

" - Async :make and linting framework -
Plug 'neomake/neomake'
  " makefile as default marker
  let g:neomake_enabled_makers = ['makeprg']
  " -- set checkers --
  let g:neomake_python_enabled_makers = ['pep8', 'pylint']

" - Dynamically show tags -
Plug 'majutsushi/tagbar'
  let tagbar_left=1
  let tagbar_width=35
  let g:tagbar_compact=1
  let g:tagbar_autofocus = 1
  " not sort by name but by the position
  let g:tagbar_sort = 0
  let g:tagbar_autoshowtag = 1

" - Git enhancement -
" -- awesome git wrapper --
Plug 'tpope/vim-fugitive'

" -- show diff status --
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle'}
  let g:gitgutter_enabled = 0
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  " fix remove on saved problem in neovim
  let g:gitgutter_sign_removed_first_line = "^_"

" - Comments and doc string  -
" -- quick comment --
Plug 'scrooloose/nerdcommenter'
  " not add spaces after comment delimiters
  let g:NERDSpaceDelims = 0
  " use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1
  " enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 0

" - Code search, view with edit mode -
Plug 'dyng/ctrlsf.vim'
  " --- mappings ---
  " disable ctrl + f for page forward
  map <C-F> <nop>
  nmap <C-F>f <Plug>CtrlSFPrompt
  vmap <C-F>f <Plug>CtrlSFVwordPath
  vmap <C-F>F <Plug>CtrlSFVwordExec
  nmap <C-F>n <Plug>CtrlSFCwordPath
  nmap <C-F>p <Plug>CtrlSFPwordPath
  " open the result of last search
  nnoremap <C-F>o :CtrlSFOpen<CR>
  " default use regex
  let g:ctrlsf_regex_pattern = 1
  let g:ctrlsf_case_sensitive = 'smart'
  " use ag as default backend
  let g:ctrlsf_ackprg = 'ag'
" --- }


" --- Snippet and General AutoComplete ----------------------------- {

" - Code snippets -
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  " set triggers -> <leader><tab>
  let g:UltiSnipsExpandTrigger="<leader><tab>"
  let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
  let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
  let g:UltiSnipsEditSplit="vertical"
  " add searching paths
  let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'custom_snippets']

" - Using tab for completion -
Plug 'ervandew/supertab'
  let g:SuperTabRetainCompletionType=2
  let g:SuperTabDefaultCompletionType="context"
  let g:SuperTabContextDefaultCompletionType = "<c-n>"
  let g:SuperTabClosePreviewOnPopupClose = 1

" - Common asynchronous completion framework: deoplete -
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  " default disabled, call deoplete#enable() when needed
  let g:deoplete#enable_at_startup = 0
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_complete_start_length = 2

  " <C-h>: close popup and delete backward char.
  inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"

  " -- support multiple cursor plugin --
  function! Multiple_cursors_before()
      let b:deoplete_disable_auto_complete = 1
  endfunction

  function! Multiple_cursors_after()
      let b:deoplete_disable_auto_complete = 0
  endfunction

  " -- deoplete external plugins --
  " speed up vim by updating folds only when called-for.
  Plug 'Konfekt/FastFold'
    nmap zuz <Plug>(FastFoldUpdate)
    let g:fastfold_savehook = 1
    let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
    let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

  " -- deoplete external sources --
  " include sources
  Plug 'Shougo/neoinclude.vim'
  " vimscript source
  Plug 'Shougo/neco-vim', { 'for': 'vim' }
  " syntax sources
  Plug 'Shougo/neco-syntax'
" --- }


" --- C CPP ----------------------------------------------- {

" - C/Cpp autocompletion -
" TODO: currently not found the best plugin for this
" Plug 'Rip-Rip/clang_complete', { 'for': ['c','cpp'] }
  let g:clang_complete_copen=1
  let g:clang_close_preview=1
  " use libclang instead of clang
  let g:clang_use_library=1
  let g:clang_library_path="/lib/libclang.so"

" - Swiching between src and head file -
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }

" --- }


" --- Python ---------------------------------------------- {

" - Neovim python host -
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" - Jedi python autocompletion and navigation -
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
  " -- mappings --
  " ctrl + c pop (c)ompletion
  let g:jedi#completions_command = "<C-C>"
  " follow identifier as far as possible,
  let g:jedi#goto_command = "<leader>d"
  " typical goto function
  let g:jedi#goto_assignments_command = "<leader>g"
  " use Pydoc
  let g:jedi#documentation_command = "K"
  " rename in current file
  let g:jedi#rename_command = "<leader>r"
  let g:jedi#usages_command = "<leader>z"

  " -- settings --
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1
  " do not auto pop on dot
  let g:jedi#popup_on_dot = 0
  " displays function call signatures in insert mode in real-time
  let g:jedi#show_call_signatures = 1
  " default select the first one
  let g:jedi#popup_select_first = 1
  let g:jedi#use_splits_not_buffers = "left"

  " default version: python 2, it will search libs of python2 dirs
  " call #jedi#force_py_version(2 or 3) function
  let g:jedi#force_py_version = 2

" - Indent using pep8 style -
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" - Better folding for python -
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
  " show docstring
  let g:SimpylFold_docstring_preview = 1
  autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
  autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" - Sort imports -
Plug 'fisadev/vim-isort', { 'for': 'python' }
" --- }


" --- (X)HTML, CSS, Javascript ------------------------------- {

" - web dev autocompletion -
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript', 'xml']}
  "  set trigger ctrl + Z
  let g:user_emmet_leader_key='<C-Z>'

" --- }


" --- Writing --------------------------------------------- {

" === Latex ===
Plug 'lervag/vimtex', { 'for': 'tex' }
  let g:tex_flavor = 'tex'  " default tex type

" --- }


" --- Colorscheme ----------------------------------------- {

Plug 'junegunn/seoul256.vim'
  " Range:   233 (darkest) ~ 239 (lightest)
  " Default: 237
  let g:seoul256_background = 235
  let g:seoul256_light_background = 256

Plug 'morhetz/gruvbox'

Plug 'joshdick/onedark.vim'
" --- }

" -------------------- End Config --------------------

" Load plugins
call plug#end()
