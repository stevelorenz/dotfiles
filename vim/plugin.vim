" vim: foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Plugin Configs for Vim
" Maintainer: Xiang, Zuo
" Email: xianglinks@gmail.com
" Sections:
"    -> General
"    -> General Programming
"    -> Snippet and General Auto Complete
"    -> Programming Language Specific
"      -> C, CPP
"      -> Python
"=========================================

" - Use Vim-Plug Plugin Manager -
"
" ------ Vim-Plug Commands ------
"    :PlugInstall     install
"    :PlugUpdate      update
"    :PlugUpgrade     upgrade
"    :PlugClean       clean

call plug#begin('~/.vim/bundle')  " dir for plugin files

" -------------------- Start Config --------------------

" --- General --------------------------------------------- {

" - Status line enhancement
" -- vim airline
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

  " config extensions
  let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1

" -- vim-airline theme repository
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme = 'simple'

" - Insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
  au FileType python let b:delimitMate_nesting_quotes = ['"']
  au FileType mail let b:delimitMate_expand_inside_quotes = 1

" - Fuzzy file, buffer and MRU finder
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

" - Show marks
Plug 'kshenoy/vim-signature'

" - Visually select increasingly larger regions of text
Plug 'terryma/vim-expand-region'
  " default mapping
  " + expand selection
  " _ shrink selection

" - Light wrapper for ack, ag, grep etc
Plug 'mileszs/ack.vim'
  " do not move the cursor to the first result automatically
  cnoreabbrev Ack Ack!
  " use ag as search command if installed
  if executable('ag')
    let g:ackprg = 'ag --vimgrep'
  endif

" - Extend machting
Plug 'vim-scripts/matchit.zip'

"- Display the idention levels
Plug 'Yggdroot/indentLine'
  let g:indentLine_enabled = 0
  let g:indentLine_char = '¦'

"  --- }


" --- General Programming --------------------------------- {

" - Collection of language packs
Plug 'sheerun/vim-polyglot'
  " -- settings for filetypes
  let python_highlight_all = 1
  " -- disable for some filetypes
  " use vimtex plugin, disable latex-box
  let g:polyglot_disabled = ['latex']

" - Dynamically show tags
Plug 'majutsushi/tagbar'
  let tagbar_left = 1
  let tagbar_width = 35
  let g:tagbar_compact = 1
  let g:tagbar_autofocus = 1
  " not sort by name but by the position
  let g:tagbar_sort = 0
  let g:tagbar_autoshowtag = 1

" - Git integration and enhancement
" -- awesome git wrapper
Plug 'tpope/vim-fugitive'
" -- show git diff and stages/undoes hunks
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle'}
  let g:gitgutter_enabled = 0
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  " fix remove on saved problem in neovim
  let g:gitgutter_sign_removed_first_line = "^_"

" - Comments and doc string
" -- quick comment
Plug 'scrooloose/nerdcommenter'
  " not add spaces after comment delimiters
  let g:NERDSpaceDelims = 0
  " use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1
  " enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 0

" - Highlight, Jump and resolve conflict markers
Plug 'rhysd/conflict-marker.vim'
  " disable default mappings
  let g:conflict_marker_enable_mappings = 0

" --- }


" --- Snippet and General AutoComplete ----------------------------- {

" - Code snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  " set triggers -> <leader><tab>
  let g:UltiSnipsExpandTrigger = "<leader><tab>"
  let g:UltiSnipsJumpForwardTrigger = "<leader><tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<leader><s-tab>"
  let g:UltiSnipsEditSplit = "vertical"
  " searching paths
  let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'custom_snippets']

" - Use tab for completion
Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = "context"
  let g:SuperTabContextDefaultCompletionType = "<c-n>"
  " close preview window when popup closes
  let g:SuperTabClosePreviewOnPopupClose = 1

" - Speed up vim by updating folds only when called-for.
Plug 'Konfekt/FastFold'
  nmap zuz <Plug>(FastFoldUpdate)
  let g:fastfold_savehook = 1
  let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
  let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" --- }


" --- Programming Language Specific ----------------------- {

" ====== C, CPP ======
" {
" }

" ====== Python ======
" {
" - Binding to autocompletion library: jedi
"   Also supports navigation and documentation viewing
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
  " -- mappings --
  " ctrl + c: trigger completion
  " default ctrl + space is used for input methods
  let g:jedi#completions_command = "<C-C>"
  " follow identifier as far as possible,
  let g:jedi#goto_command = "<leader>d"
  " typical goto function
  let g:jedi#goto_assignments_command = "<leader>g"
  " show documentation
  let g:jedi#documentation_command = "K"
  " rename in current file
  let g:jedi#rename_command = "<leader>r"
  let g:jedi#usages_command = "<leader>z"

  " -- settings --
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 0
  " disable auto pop on dot
  let g:jedi#popup_on_dot = 0
  let g:auto_close_doc = 1
  " displays function call signatures in insert mode in real-time
  let g:jedi#show_call_signatures = 0
  " default select the first one
  let g:jedi#popup_select_first = 1
  " open new split for 'go to' result
  let g:jedi#use_splits_not_buffers = "winwidth"
  " set python interpreter version
    " default use sys.version_info from 'python' in your $PATH
    " call jedi#force_py_version(py_version) to set directly
  let g:jedi#force_py_version = "auto"

" - Indent using pep8 style
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }

" - Extend % motion for python
Plug 'vim-scripts/python_match.vim', { 'for': 'python' }

" - Better folding for python
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
  " show docstring in fold mode
  let g:SimpylFold_docstring_preview = 1
  autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
  autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

" - Generate python docstring
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
" }

" --- }

" -------------------- End Config --------------------

" Load plugins
call plug#end()
