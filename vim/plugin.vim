" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Plugin Configs for Vim/NeoVim
" Maintainer: Xiang, Zuo
" Email: xianglinks@gmail.com
" Sections:
"    -> General
"    -> General Programming
"    -> General Editing
"    -> Snippet and General Auto Complete
"    -> Programming Language Specific
"      -> C, CPP
"      -> Python
"      -> Rust
"      -> (X)HTML
"      -> Javascript
"      -> (La)Tex
"    -> Documentation and Writing
"    -> Colorscheme
"    -> Test: plugins under test
"
" MARK: Currently there are too many plugins and I plan to DISABLE some that are not essential for
" my daily usage. After some testing, I will remove some of them in the next stable version.
" "Old" or disabled plugins's configuration is only commented out for potential backwark hopping.
"=========================================

" - Use Vim-Plug Plugin Manager -
"
" ------ Vim-Plug Commands ------
"    :PlugInstall     install
"    :PlugUpdate      update
"    :PlugUpgrade     upgrade
"    :PlugClean       clean

call plug#begin('~/.config/nvim/bundle')  " dir for plugin files

" -------------------- Start Config --------------------

" inspired by spf13, choose collections of plugins to be installed.
" remove element in the list to disable a collection of plugins.
" for example, remove 'python' will disable all plugins in the python section.
if !exists('g:bundle_groups')
    " All available groups
    "let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
    "            \ 'c_cpp', 'python', 'go', '(x)html', 'javascript', 'text', 'colorscheme']
    "
    let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
                \ 'c_cpp', 'python', 'rust', 'text', 'colorscheme', 'test']
endif

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')

    " - Status line enhancement
    " -- lightline: a light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'colorscheme': 'one',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
                \   'gitbranch': 'fugitive#head'
                \ },
                \ }

    " lightline plugin for buffer line
    Plug 'mengelbrecht/lightline-bufferline'
    let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
    let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type   = {'buffers': 'tabsel'}

    " - Built-in directory browser: netrw
    " use tree view
    let g:netrw_liststyle = 3
    let g:netrw_banner = 1
    " set width to 25% of the page
    let g:netrw_winsize = 25
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1

    if has('python') || has('python3')
        " An asynchronous fuzzy finder which is used to quickly locate files, buffers, mrus, tags, etc. in large project.
        Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
        noremap <m-f> :cclose<cr>:LeaderfFunction!<cr>
        noremap <m-t> :cclose<cr>:LeaderfBufTag!<cr>
        let g:Lf_MruMaxFiles = 2048
        let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
        " LeaderF with tags
        let g:Lf_GtagsAutoGenerate = 0
    else
        " - Fuzzy file, buffer and MRU finder
        Plug 'ctrlpvim/ctrlp.vim'
        " map it to space plus p, use <C-P> for multiple search plugins
        let g:ctrlp_map = '<space>p'
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
    endif


    " - Undo history visualizer
    Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
    let g:undotree_SetFocusWhenToggle = 1

    " - Fast and easy cursor motion
    " -- inter lines
    "Plug 'Lokaltog/vim-easymotion'
    "let g:EasyMotion_smartcase = 1
    "" default use one <leader> as trigger
    "map  <leader>f <Plug>(easymotion-bd-f)
    "nmap <leader>f <Plug>(easymotion-overwin-f)
    "" <leader>s{char} to move to {char}
    "" s{char}{char} to move to {char}{char}
    "nmap s <Plug>(easymotion-overwin-f2)
    " -- intra line
    Plug 'unblevable/quick-scope'
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    "let g:qs_first_occurrence_highlight_color = 155
    "let g:qs_second_occurrence_highlight_color = 81

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

    "- Display the indention levels
    "Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle' }
    Plug 'Yggdroot/indentLine',
    let g:indentLine_enabled = 1
    let g:indentLine_char = '¦'
    let g:indentLine_setConceal = 0

    " - Search results counter
    Plug 'vim-scripts/IndexedSearch'

    " - Enhancing in-buffer search experience
    Plug 'junegunn/vim-slash'

    " - Beakdown VIM's --startuptime output
    Plug 'tweekmonster/startuptime.vim'

endif

"  --- }


" --- General Editing ------------------------------------- {

if count(g:bundle_groups, 'general_editing')

    " - Insert mode auto-completion for quotes, parentheses, brackets
    Plug 'Raimondi/delimitMate'
    au FileType python let b:delimitMate_nesting_quotes = ['"']
    au FileType mail let b:delimitMate_expand_inside_quotes = 1

    " - Surroundings editing
    Plug 'tpope/vim-surround'

    " - Enable repeating supported plugin maps with "."
    Plug 'tpope/vim-repeat'

    " - Multiple cursor editing
    Plug 'terryma/vim-multiple-cursors'
    " use default mapping
    let g:multi_cursor_use_default_mapping=1
    let g:multi_cursor_next_key = '<C-n>'
    let g:multi_cursor_prev_key = '<C-p>'
    let g:multi_cursor_skip_key = '<C-x>'
    let g:multi_cursor_quit_key = '<Esc>'

    " - Underlines the word under the cursor
    Plug 'itchyny/vim-cursorword'

    " - Better whitespace highlighting
    Plug 'ntpeters/vim-better-whitespace'

    " - Show contents of the registers
    Plug 'junegunn/vim-peekaboo'

    " - Text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'"
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
    Plug 'sgur/vim-textobj-parameter'

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

    " - Asynchronous Lint Engine (ALE)
    if has('nvim') || v:version >= 800
        Plug 'w0rp/ale'
        let g:ale_enabled=1
        let g:ale_sign_column_always = 1
        " ALE automatically updates the loclist which makes it impossible to use some other plugins
        " such as GV
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1
        "let g:ale_open_list = 1
        let g:ale_lint_on_save = 1
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_enter = 'never'

        " declare enabled linters
        let g:ale_linters = {
                    \   'python': ['flake8'],
                    \}

        " language specfic settings
        let g:ale_python_flake8_args = '--ignore=E501,E226,E126'
        let g:ale_python_flake8_options = '--ignore=E501,E226,E126'

        " Add default fixers
        let g:ale_fixers = {
                    \   'javascript': ['prettier'],
                    \   'javascript.jsx': ['prettier'],
                    \   'json': ['prettier'],
                    \   'scss': ['prettier'],
                    \   'bash': ['shfmt'],
                    \   'zsh': ['shfmt'],
                    \   'elixir': ['mix_format'],
                    \   'ruby': ['rubocop'],
                    \   'rust': ['rustfmt'],
                    \   'elm': ['elm-format'],
                    \}
    endif

    " - Viewer & Finder for LSP symbols and tags
    Plug 'liuchengxu/vista.vim'
    let g:vista_sidebar_position= 'vertical topleft'

    " - Tags management
    Plug 'ludovicchabant/vim-gutentags'
    set tags=./.tags;,.tags
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = '.tags'
    " Add suppport for ctags and gtags, gtags is disabled by default
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    endif
    " if executable('cscope')
    "     let g:gutentags_modules += ['cscope']
    " endif
    "if executable('gtags-cscope') && executable('gtags')
    "    let g:gutentags_modules += ['gtags_cscope']
    "    let g:gutentags_auto_add_gtags_cscope = 0
    "endif

    " put tags file to the cache directory
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
    endif

    " - Git integration and enhancement
    " -- awesome git wrapper
    " ISSUE: high startup time.
    " Plug 'tpope/vim-fugitive'
    " -- show git diff asynchronously
    Plug 'mhinz/vim-signify'

    " - Comment stuff out
    Plug 'tpope/vim-commentary'

    " - Code search, view with edit mode
    Plug 'dyng/ctrlsf.vim'
    " --- mappings ---
    nmap <C-P>f <Plug>CtrlSFPrompt
    vmap <C-P>f <Plug>CtrlSFVwordPath
    vmap <C-P>F <Plug>CtrlSFVwordExec
    nmap <C-P>n <Plug>CtrlSFCwordPath
    nmap <C-P>p <Plug>CtrlSFPwordPath
    " open the result of last search
    nnoremap <C-P>o :CtrlSFOpen<CR>
    autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp
                \ let g:ctrlsf_indent = 8
    " default use regex pattern
    let g:ctrlsf_regex_pattern = 1
    let g:ctrlsf_case_sensitive = 'smart'
    " use ag as backend if available
    if executable('ag')
        let g:ctrlsf_ackprg = 'ag'
    endif

    " - Simple template plugin
    Plug 'aperezdc/vim-template'
    " disable auto insertion
    let g:templates_no_autocmd = 1

    " - Run commands quickly
    Plug 'skywind3000/asyncrun.vim'

    " - Easy code formatting
    " Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
    Plug 'sbdchd/neoformat', {'on': 'Neoformat'}
    let g:neoformat_enabled_python = ['black', 'autopep8', 'docformatter']

    " - Preview tags, files and functions
    Plug 'skywind3000/vim-preview'
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

endif

" --- }


" --- Snippet and General AutoComplete ----------------------------- {

if count(g:bundle_groups, 'snippet_autocomplete')

    " - Code snippets
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    " set triggers -> <leader><tab>
    let g:UltiSnipsExpandTrigger = "<leader><tab>"
    let g:UltiSnipsListSnippets = "<f9>"
    let g:UltiSnipsJumpForwardTrigger = "<leader><tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<leader><s-tab>"
    let g:UltiSnipsEditSplit = "vertical"
    " Fully disable snipmate
    "let g:UltiSnipsEnableSnipMate = 0
    " searching paths
    let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'custom_snippets']

    " - Autocomplete framework
    " Lightweight chained completion
    Plug 'lifepillar/vim-mucomplete'
    set completeopt+=menuone,noselect,noinsert
    " shut off completion messages and disable beep
    set shortmess+=c
    set belloff+=ctrlg
    let g:mucomplete#enable_auto_at_startup = 1
    let g:mucomplete#completion_delay = 1

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
if count(g:bundle_groups, 'c_cpp')
    " - Linux coding style
    Plug 'vivien/vim-linux-coding-style', { 'for': ['c', 'cpp'] }

    " - Simplify Doxygen documentation
    Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp'] }
    let g:DoxygenToolkit_briefTag_funcName = "yes"

    "- Additional Vim syntax highlighting for C++
    Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp'] }
endif
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

    " - Better folding for python
    Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
    " show docstring in fold mode
    let g:SimpylFold_docstring_preview = 1
    " autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    " autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

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

" Rust {
if count(g:bundle_groups, 'rust')
    " - Configuration for rust.
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
endif

" Golang {
if count(g:bundle_groups, 'go')
    "- MARK: vim-go plans to drop support for Neovim
    " So the gopls is used via LSP client for go development
    " - Go development plugin for Vim
    " Plug 'fatih/vim-go', { 'for': ['go'], 'do': ':GoUpdateBinaries' }
    " Run GoUpdateBinaries  manually, it takes time during every update
    " Plug 'fatih/vim-go', { 'for': ['go']}
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
    " - Syntax for javascript libraries
    Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['html', 'css', 'javascript'] }
endif
" }

" --- }


" --- Documentation and Writing --------------------------- {

" - Editing latex files
if count(g:bundle_groups, 'text')
    Plug 'lervag/vimtex', { 'for': 'tex' }
    let g:tex_flavor = 'tex'  " default tex type
    let g:vimtex_compiler_progname = 'nvr'
endif

" --- }


" --- Colorscheme ----------------------------------------- {

" Colorscheme that are active updated
" Stable and inactive ones are stored in colors dir

if count(g:bundle_groups, 'colorscheme')
    Plug 'lifepillar/vim-solarized8'
    let g:solarized_italics = 0

    Plug 'joshdick/onedark.vim'

    Plug 'liuchengxu/space-vim-dark'
endif

" --- }


" --- Plugins Under Test ---------------------------------- {

if count(g:bundle_groups, 'test')

    " - Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
    Plug 'gyim/vim-boxdraw'

    " - Vim Markdown mode
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'

    " - Changes Vim working directory to project root
    Plug 'airblade/vim-rooter'
    let g:rooter_manual_only = 1

    " - Jump to any location
    Plug 'justinmk/vim-sneak'
    let g:sneak#label = 1

    " - Generate table of contents for Markdown files
    Plug 'mzlogin/vim-markdown-toc'

    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
    Plug 'liuchengxu/vim-clap'

    " - Language server protocol (LSP) support
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
    " required for operations modifying multiple buffers like rename.
    set hidden
    let g:LanguageClient_serverCommands = {
                \ 'c': ['clangd'],
                \ 'cpp': ['clangd'],
                \ 'go': ['gopls'],
                \ 'python': ['pyls'],
                \ 'rust': ['rustup', 'run', 'stable', 'rls'],
                \ }
    let g:LanguageClient_diagnosticsEnable = 0
    let g:LanguageClient_fzfContextMenu = 0
    let g:LanguageClient_useVirtualText = 0

endif

" --- }


" -------------------- End Config --------------------

" Load plugins
call plug#end()
