" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Plugin Configs for Vim/NeoVim
" Maintainer: Xiang, Zuo
" Email: xianglinks@gmail.com
" Version: 1.0
" Sections:
"    -> General
"    -> General Programming
"    -> Snippet and General Auto Complete
"    -> Programming Language Specific
"      -> C, CPP
"      -> Python
"      -> (X)HTML
"      -> Javascript
"    -> Documentation and Writing
"    -> Colorscheme
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

" inspired by spf13, choose collections of plugins to be installed.
" remove element in the list to disable a collection of plugins.
" for example, remove 'python' will disable all plugins in the python section.
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'general_programming', 'snippet_autocomplete', 'python', '(x)html', 'javascript', 'tex', 'colorscheme']
endif

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')
    " - Status line enhancement
    " -- vim airline
    Plug 'bling/vim-airline'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '▶'
    let g:airline_left_alt_sep = '❯'
    let g:airline_right_sep = '◀'
    let g:airline_right_alt_sep = '❮'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1

    " -- vim-airline theme repository
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'simple'

    " - Built-in directory browser: netrw
    " use tree view
    let g:netrw_liststyle = 3
    let g:netrw_banner = 1
    " set width to 25% of the page
    let g:netrw_winsize = 25
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1

    " - Insert mode auto-completion for quotes, parentheses, brackets
    Plug 'Raimondi/delimitMate'
    au FileType python let b:delimitMate_nesting_quotes = ['"']
    au FileType mail let b:delimitMate_expand_inside_quotes = 1

    " - Fuzzy file, buffer and MRU finder
    Plug 'ctrlpvim/ctrlp.vim'
    " map it to ctrl+p plus p, use <C-P> for multiple search plugins
    let g:ctrlp_map = '<C-P>p'
    let g:ctrlp_cmd = 'CtrlP'
    " use the dir of the current file as searching root
    " unless it is a subdir of the cwd
    let g:ctrlp_working_path_mode = 'a'
    let g:ctrlp_match_window_bottom = 1
    let g:ctrlp_max_height = 15
    " from bottom to top
    let g:ctrlp_match_window_reversed = 1
    " buffer of most recently used files
    let g:ctrlp_mruf_max = 500
    let g:ctrlp_follow_symlinks = 1

    " use ack as backend if available
    if executable('ag')
        " can use a local or global .agignore to ignore files
        let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -f -g ""'
    elseif executable('ack')
        let g:ctrlp_user_command = 'ack %s --nocolor -f'
    else
        " use default grep, ignore files in .gitignore
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    endif

    " - Extension to ctrlp, for fuzzy command finder
    Plug 'fisadev/vim-ctrlp-cmdpalette', { 'on': 'CtrlPCmdPalette' }
    nnoremap <C-P>c :CtrlPCmdPalette<CR>

    " - Surroundings editing
    Plug 'tpope/vim-surround'

    " - Enable repeating supported plugin maps with "."
    Plug 'tpope/vim-repeat'

    " - Undo history visualizer
    Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
    let g:undotree_SetFocusWhenToggle = 1

    " - Fast and easy cursor motion
    " -- inter lines
    Plug 'Lokaltog/vim-easymotion'
    let g:EasyMotion_smartcase = 1
    " default use one <leader> as trigger
    map  <leader>f <Plug>(easymotion-bd-f)
    nmap <leader>f <Plug>(easymotion-overwin-f)
    " <leader>s{char} to move to {char}
    " s{char}{char} to move to {char}{char}
    nmap s <Plug>(easymotion-overwin-f2)

    " -- intra line
    Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    let g:qs_first_occurrence_highlight_color = 155
    let g:qs_second_occurrence_highlight_color = 81

    " - Multiple cursor editing
    Plug 'terryma/vim-multiple-cursors'
    " use default mapping
    let g:multi_cursor_use_default_mapping=1
    let g:multi_cursor_next_key = '<C-n>'
    let g:multi_cursor_prev_key = '<C-p>'
    let g:multi_cursor_skip_key = '<C-x>'
    let g:multi_cursor_quit_key = '<Esc>'

    " - Show marks
    Plug 'kshenoy/vim-signature'

    " - Visually select increasingly larger regions of text
    Plug 'terryma/vim-expand-region'
    " + expand selection
    " _ shrink selection

    " - Light wrapper for ack, ag, grep etc
    Plug 'mileszs/ack.vim', { 'on': ['Ack', 'Ack!'] }
    " do not move the cursor to the first result automatically
    cnoreabbrev Ack Ack!
    " use ag as backend if available
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif

    " - Extend matching
    Plug 'vim-scripts/matchit.zip'

    "- Display the indention levels
    Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
    let g:indentLine_enabled = 0
    let g:indentLine_char = '¦'

    " - Search results counter
    Plug 'vim-scripts/IndexedSearch'

    " - Pairs of handy bracket mappings
    Plug 'tpope/vim-unimpaired'

    " - Underlines the word under the cursor
    Plug 'itchyny/vim-cursorword'
endif
    
"  --- }


" --- General Programming --------------------------------- {

if count(g:bundle_groups, 'general_programming')
    " - Collection of language packs
    Plug 'sheerun/vim-polyglot'
    " -- settings for filetypes
    " --- python
    let g:python_highlight_all = 1
    " --- javascript
    let g:javascript_plugin_jsdoc = 1
    " -- disable individual packs
    " --- use vimtex plugin, disable latex-box
    let g:polyglot_disabled = ['latex']

    " - Async :make and linting framework
    Plug 'neomake/neomake'
    " use makefile as default marker
    let g:neomake_enabled_makers = ['makeprg']
    " -- set language checkers --
    let g:neomake_python_enabled_makers = ['pep8', 'pylint']

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

    " - Intensely orgasmic commenting
    Plug 'scrooloose/nerdcommenter'
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 0
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

    " - Code search, view with edit mode
    Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
    " --- mappings ---
    nmap <C-P>f <Plug>CtrlSFPrompt
    vmap <C-P>f <Plug>CtrlSFVwordPath
    vmap <C-P>F <Plug>CtrlSFVwordExec
    nmap <C-P>n <Plug>CtrlSFCwordPath
    nmap <C-P>p <Plug>CtrlSFPwordPath
    " open the result of last search
    nnoremap <C-P>o :CtrlSFOpen<CR>
    " default use regex pattern
    let g:ctrlsf_regex_pattern = 1
    let g:ctrlsf_case_sensitive = 'smart'
    " use ag as backend if available
    if executable('ag')
        let g:ctrlsf_ackprg = 'ag'
    endif

    " - Highlight, Jump and resolve conflict markers
    Plug 'rhysd/conflict-marker.vim', { 'on': 'ConflictMarkerNextHunk' }
    " disable default mappings
    let g:conflict_marker_enable_mappings = 0

    " - Simple template plugin
    Plug 'aperezdc/vim-template'
    " disable auto insertion
    let g:templates_no_autocmd = 1

    " - Eclipse like task list
    Plug 'fisadev/FixedTaskList.vim', { 'on': 'TaskList' }

    " - Run commands quickly
    Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }

    " - Easy code formatting
    Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}

    " - Use Zeal: Offline documentation viewer
    Plug 'KabbAmine/zeavim.vim', {'on': [
                \   'Zeavim', 'Docset',
                \   '<Plug>Zeavim',
                \   '<Plug>ZVVisSelection',
                \   '<Plug>ZVKeyDocset',
                \   '<Plug>ZVMotion'
                \ ]}
    let g:zv_disable_mapping = 1
endif

" --- }


" --- Snippet and General AutoComplete ----------------------------- {

if count(g:bundle_groups, 'snippet_autocomplete')
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
    " remember last completion type until 'esc' to normal mode
    let g:SuperTabRetainCompletionType=2

    " - Speed up vim by updating folds only when called-for.
    Plug 'Konfekt/FastFold'
    nmap zuz <Plug>(FastFoldUpdate)
    let g:fastfold_savehook = 1
    let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
    let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
endif

" --- }


" --- Programming Language Specific ----------------------- {

" C, CPP {
" - Simplify Doxygen documentation
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp'] }
let g:DoxygenToolkit_briefTag_funcName = "yes"
" }

" Python {
if count(g:bundle_groups, 'python')
    " - Binding to autocompletion library: jedi
    "   also supports navigation and documentation viewing
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " -- mappings --
    let g:jedi#completions_command = "<C-C>"
    " follow identifier as far as possible,
    let g:jedi#goto_command = "<leader>d"
    " typical goto function
    let g:jedi#goto_assignments_command = "<leader>g"
    " show documentation
    let g:jedi#documentation_command = "K"
    " rename in current file
    let g:jedi#rename_command = "<leader>r"
    " show usages in current file
    let g:jedi#usages_command = "<leader>z"

    " -- settings --
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    " disable auto pop on dot
    let g:jedi#popup_on_dot = 0
    " default select the first one
    let g:jedi#popup_select_first = 1
    " close doc after completion
    let g:auto_close_doc = 1
    " disable function call signatures in insert mode in real-time
    let g:jedi#show_call_signatures = 0
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

    " - Sort python imports
    Plug 'fisadev/vim-isort', { 'for': 'python' }
    " disable mapping
    let g:vim_isort_map = ''

    " - Generate python docstring
    Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
    " disable key mappings
    let g:pydocstring_enable_mapping = 0
endif
" }

" (X)HTML {
if count(g:bundle_groups, '(x)html')
    " - Emmet support
    Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
    let g:user_emmet_leader_key='<C-E>'

    " - Highlight matched tags
    Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html', 'css', 'javascript'] }
endif
" }

" Javascript {
if count(g:bundle_groups, 'javascript')
    " - Tern plugin for vim
    Plug 'ternjs/tern_for_vim', { 'for': ['html', 'css', 'javascript'] }

    " - Syntax for javascript libraries
    Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['html', 'css', 'javascript'] }
endif
" }

" --- }


" --- Documentation and Writing --------------------------- {

" - Editing latex files
if count(g:bundle_groups, 'tex')
    Plug 'lervag/vimtex', { 'for': 'tex' }
    let g:tex_flavor = 'tex'  " default tex type
endif

" --- }


" --- Colorscheme ----------------------------------------- {

" Colorscheme that are active updated
" Stable and inactive ones are stored in colors dir

if count(g:bundle_groups, 'colorscheme')
    Plug 'junegunn/seoul256.vim'
    " Range:   233 (darkest) ~ 239 (lightest)
    " Default: 237
    let g:seoul256_background = 235
    let g:seoul256_light_background = 256

    Plug 'joshdick/onedark.vim'
endif

" --- }


" -------------------- End Config --------------------

" Load plugins
call plug#end()
