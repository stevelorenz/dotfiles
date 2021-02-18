" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Plugin Configs for NeoVim
" Maintainer: Xiang, Zuo
" Email: xianglinks@gmail.com
" Sections:
"    -> General
"    -> General Programming
"    -> General Editing
"    -> Snippet and General Auto Complete
"    -> Programming Language Specific
"    -> Documentation and Writing
"    -> Colorscheme
"    -> Test: plugins under test
"    -> Backup: configuration backup of currently disabled/removed plugins.
"
" Notes:
"    -> General programming language features are supported by using Language Server Protocol (LSP).
"       Currently used client plugin is prabirshrestha/vim-lsp.
"       The Programming Language Specific section includes plugins that provide additional
"       functions which are not provided by LSP.
"       Some programming languages use vim-lsp for auto-completion. The omnifunc integration of
"       Check the configuration of vim-lsp plugin for details.
"       Vim-lsp-settings plugin is used to install lsp servers.
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

" Inspired by spf13, choose collections of plugins to be installed.
" remove element in the list to disable a collection of plugins.
" for example, remove 'python' will disable all plugins in the python section.
if !exists('g:bundle_groups')
    " All available groups.
    "let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
    "            \ 'c_cpp', 'python', 'rust', 'web_frontend', 'text', 'colorscheme', 'test']
    "
    " Enabled groups for Zuo's development tasks.
    let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
                \ 'c_cpp', 'python', 'rust', 'web_frontend', 'text', 'colorscheme', 'test']
endif

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')

    " - Status line enhancement
    " -- lightline: a light and configurable statusline/tabline plugin for Vim
    Plug 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'colorscheme': 'onedark',
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
                \ },
                \ 'component_function': {
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


    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
    Plug 'liuchengxu/vim-clap'
    let g:clap_theme = 'material_design_dark'

    " - Undo history visualizer
    Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
    let g:undotree_SetFocusWhenToggle = 1

    " - Show marks
    Plug 'kshenoy/vim-signature'

    " - Show thin vertical lines at each indentation level for code indented with spaces.
    Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
        autocmd! User indentLine doautocmd indentLine Syntax
    let g:indentLine_color_term = 239
    let g:indentLine_color_gui = '#616161'

    " - Enhancing in-buffer search experience
    Plug 'junegunn/vim-slash'

    " - Beakdown VIM's --startuptime output
    Plug 'tweekmonster/startuptime.vim'

endif

"  --- }


" --- General Editing ------------------------------------- {

if count(g:bundle_groups, 'general_editing')

    " - Handle surroundings
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

endif

"  --- }


" --- General Programming --------------------------------- {

if count(g:bundle_groups, 'general_programming')

    " - Async Language Server Protocol plugin for vim8 and neovim
    Plug 'prabirshrestha/vim-lsp'
    " call lsp#enable() to enable it.
    let g:lsp_auto_enable = 1
    " disable diagnostics support
    let g:lsp_diagnostics_enabled = 0
    " let lsp automatically handle folding.
    set foldmethod=expr
        \ foldexpr=lsp#ui#vim#folding#foldexpr()
        \ foldtext=lsp#ui#vim#folding#foldtext()
    let g:lsp_highlight_references_enabled = 1

    " - Auto configurations for LSP for vim-lsp
    Plug 'mattn/vim-lsp-settings'
    " directory to install LSP servers.
    let g:lsp_settings_servers_dir = "~/.local/share/lsp_servers"

    " - Asynchronous Lint Engine (ALE)
    if has('nvim') || v:version >= 800
        Plug 'w0rp/ale'
        let g:ale_enabled=1
        let g:ale_sign_column_always = 1
        " ALE automatically updates the loclist which makes it impossible to
        " use some other plugins.
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1
        let g:ale_open_list = 0
        " Trigger linting manually.
        let g:ale_lint_on_save = 1
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_enter = 'never'
    endif

    " - Viewer & Finder for LSP symbols and tags
    Plug 'liuchengxu/vista.vim'
    let g:vista_sidebar_position= 'vertical topleft'

    " - Tags management
    Plug 'ludovicchabant/vim-gutentags'
    set tags=./.tags;,.tags
    let g:gutentags_enabled = 0
    let g:gutentags_generate_on_new = 0
    let g:gutentags_generate_on_write = 0
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = '.tags'
    " Add support for ctags and gtags, gtags is disabled by default
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
    " Async completion in pure vim script for vim8 and neovim
    Plug 'prabirshrestha/asyncomplete.vim'
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    let g:asyncomplete_auto_popup = 0

    " disable auto-popup, use tab to show autocomplete.
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ asyncomplete#force_refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    " allow modifying the completeopt variable, or it will be overridden all the time.
    let g:asyncomplete_auto_completeopt = 0
    set completeopt=menuone,noinsert,noselect,preview
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    " completion sources
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

endif

" --- }


" --- Programming Language Specific ----------------------- {

" C, CPP {
if count(g:bundle_groups, 'c_cpp')
    " - Linux coding style for C
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
    " - Generate python docstring
    Plug 'heavenshell/vim-pydocstring', { 'for': 'python', 'tag': '1.0.0'}
    " disable key mappings
    let g:pydocstring_enable_mapping = 0
endif
" }

" Rust {
if count(g:bundle_groups, 'rust')
    " - Configuration for rust.
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
endif
" }

" }


" Web Frontend {
if count(g:bundle_groups, 'web_frontend')
    " - Emmet support
    Plug 'mattn/emmet-vim', { 'for': ['xml', 'html', 'css', 'javascript'] }
    let g:user_emmet_leader_key='<C-E>'

    " - Highlight matched tags
    Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html', 'css', 'javascript'] }
endif
" }

" --- }


" --- Documentation and Writing --------------------------- {

" - Editing latex files
if count(g:bundle_groups, 'text')
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

    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" --- }


" --- Plugins Under Test ---------------------------------- {

if count(g:bundle_groups, 'test')
    " On-demand lazy load
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

    " Vim motions on speed!
    Plug 'easymotion/vim-easymotion'

    " True Sublime Text style multiple selections for Vim
    " Plug 'terryma/vim-multiple-cursors'
    Plug 'mg979/vim-visual-multi'

    " Underlines the word under the cursor
    Plug 'itchyny/vim-cursorword'
    let g:cursorword_delay = 400

    " Rainbow parentheses improved
    Plug 'luochen1990/rainbow'
    " enable it later via :RainbowToggle
    let g:rainbow_active = 0

    " Language Server Protocol snippets in vim using vim-lsp and UltiSnips
    Plug 'thomasfaingnaert/vim-lsp-snippets'
    Plug 'thomasfaingnaert/vim-lsp-ultisnips'

    " - A tree explorer plugin for vim.
    Plug 'preservim/nerdtree'
    " Open the existing NERDTree on each new tab.
    autocmd BufWinEnter * silent NERDTreeMirror
    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
        \ quit | endif

endif

" --- }


" --- Backup ---------------------------------------------- {

    " - Binding to autocompletion library: jedi
    "   also supports navigation and documentation viewing
    " Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    " " -- mappings --
    " let g:jedi#completions_command = "<C-C>"
    " " follow identifier as far as possible,
    " let g:jedi#goto_command = "<leader>d"
    " " typical goto function
    " let g:jedi#goto_assignments_command = "<leader>g"
    " " show documentation
    " let g:jedi#documentation_command = "K"
    " " rename in current file
    " let g:jedi#rename_command = "<leader>r"
    " " show usages in current file
    " let g:jedi#usages_command = "<leader>z"
    " " -- settings --
    " let g:jedi#auto_initialization = 1
    " let g:jedi#auto_vim_configuration = 0
    " " disable auto pop on dot
    " let g:jedi#popup_on_dot = 0
    " " default select the first one
    " let g:jedi#popup_select_first = 1
    " " close doc after completion
    " let g:auto_close_doc = 1
    " " disable function call signatures in insert mode in real-time
    " let g:jedi#show_call_signatures = 0
    " " open new split for 'go to' result
    " let g:jedi#use_splits_not_buffers = "winwidth"
    " " set python interpreter version
    " " default use sys.version_info from 'python' in your $PATH
    " " call jedi#force_py_version(py_version) to set directly
    " let g:jedi#force_py_version = "auto"

    " - Better folding for python
    " Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
    " " show docstring in fold mode
    " let g:SimpylFold_docstring_preview = 1
    " " autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    " " autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

    " Plug 'autozimu/LanguageClient-neovim', {
    "             \ 'branch': 'next',
    "             \ 'do': 'bash install.sh',
    "             \ }
    " " required for operations modifying multiple buffers like rename.
    " set hidden
    " let g:LanguageClient_serverCommands = {
    "             \ 'c': ['clangd'],
    "             \ 'cpp': ['clangd'],
    "             \ 'go': ['gopls'],
    "             \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    "             \ 'python': ['/bin/pyls'],
    "             \ }
    " let g:LanguageClient_diagnosticsEnable = 0
    " let g:LanguageClient_fzfContextMenu = 0
    " let g:LanguageClient_useVirtualText = 0


    " - Fuzzy file, buffer and MRU finder
    " Plug 'ctrlpvim/ctrlp.vim'
    " " map it to space plus p, use <C-P> for multiple search plugins
    " let g:ctrlp_map = '<space>p'
    " let g:ctrlp_cmd = 'CtrlP'
    " " use the dir of the current file as searching root
    " " unless it is a subdir of the cwd
    " let g:ctrlp_working_path_mode = 'a'
    " let g:ctrlp_match_window_bottom = 1
    " let g:ctrlp_max_height = 15
    " " from bottom to top
    " let g:ctrlp_match_window_reversed = 1
    " " buffer of most recently used files
    " let g:ctrlp_mruf_max = 500
    " let g:ctrlp_follow_symlinks = 1
    " " use ack as backend if available
    " if executable('ag')
    "     " can use a local or global .agignore to ignore files
    "     let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -f -g ""'
    " elseif executable('ack')
    "     let g:ctrlp_user_command = 'ack %s --nocolor -f'
    " else
    "     " use default grep, ignore files in .gitignore
    "     let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    " endif
    " " - Extension to ctrlp, for fuzzy command finder
    " Plug 'fisadev/vim-ctrlp-cmdpalette', { 'on': 'CtrlPCmdPalette' }
    " nnoremap <C-P>c :CtrlPCmdPalette<CR>

    " - Fast and easy cursor motion
    " -- inter lines
    " Plug 'justinmk/vim-sneak'
    " let g:sneak#label = 1
    "

    " if has('python') || has('python3')
    "     " An asynchronous fuzzy finder which is used to quickly locate files, buffers, mrus, tags, etc. in large project.
    "     Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    "     noremap <m-f> :cclose<cr>:LeaderfFunction!<cr>
    "     noremap <m-t> :cclose<cr>:LeaderfBufTag!<cr>
    "     let g:Lf_MruMaxFiles = 2048
    "     let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
    "     " LeaderF with tags
    "     let g:Lf_GtagsAutoGenerate = 0
    "     let g:Lf_WindowPosition = 'popup'
    " endif

    " - Visually select increasingly larger regions of text
    " Plug 'terryma/vim-expand-region'
    " + expand selection
    " _ shrink selection

    " ISSUE: It slows the moving of the cursor in normal and insert mode...
    " - Insert mode auto-completion for quotes, parentheses, brackets
    " Plug 'Raimondi/delimitMate'
    " au FileType python let b:delimitMate_nesting_quotes = ['"']
    " au FileType mail let b:delimitMate_expand_inside_quotes = 1

    " Lightweight chained completion
    " Plug 'lifepillar/vim-mucomplete'
    " set completeopt+=menuone,noselect,noinsert
    " shut off completion messages and disable beep
    " set shortmess+=c
    " set belloff+=ctrlg
    " Use MUcompleteAutoToggle to enable/disable it manually.
    " let g:mucomplete#enable_auto_at_startup = 1
    " let g:mucomplete#completion_delay = 1

"  }


" -------------------- End Config --------------------

" Load plugins
call plug#end()
