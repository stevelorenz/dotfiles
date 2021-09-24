" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Plugin Configuration for NeoVIM
"        Plugins are chosen ONLY for my PERSONAL workflow
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
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
    let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
                \ 'c_cpp', 'python', 'rust', 'web_frontend', 'text', 'colorscheme', 'test']
endif

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')

    " - Lean & mean status/tabline for vim that's light as air
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='onedark'

    " - Built-in directory browser: netrw
    " use tree view
    let g:netrw_liststyle = 3
    let g:netrw_banner = 1
    " set width to 25% of the page
    let g:netrw_winsize = 25
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1


    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
    "   TODO: Consider nvim-telescope/telescope.nvim ?
    Plug 'liuchengxu/vim-clap'
    let g:clap_theme = 'material_design_dark'
    let g:clap_layout = { 'relative': 'editor' }

    " - Undo history visualizer
    Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
    let g:undotree_SetFocusWhenToggle = 1

    " - Show thin vertical lines at each indentation level for code indented with spaces.
    Plug 'Yggdroot/indentLine'
        autocmd! User indentLine doautocmd indentLine Syntax
    let g:indentLine_color_term = 239
    let g:indentLine_color_gui = '#616161'

    " - Enhancing in-buffer search experience
    Plug 'junegunn/vim-slash'

    " - Beakdown VIM's --startuptime output
    Plug 'tweekmonster/startuptime.vim'

    " - A tree explorer plugin for vim.
    Plug 'preservim/nerdtree'

    " - Adds file type icons to Vim plugins
    Plug 'ryanoasis/vim-devicons'

    " - Nvim Treesitter configurations and abstraction layer
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " - Rainbow parentheses improved
    Plug 'luochen1990/rainbow'
    " enable it later via :RainbowToggle
    let g:rainbow_active = 0
endif

"  --- }


" --- General Editing ------------------------------------- {

if count(g:bundle_groups, 'general_editing')

    " - Handle surroundings
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

    " - True Sublime Text style multiple selections for Vim
    Plug 'mg979/vim-visual-multi'

endif

"  --- }


" --- General Programming --------------------------------- {

if count(g:bundle_groups, 'general_programming')

    " - Built-in lsp related plugins
    "   These plugins are configured with lua and current Configuration is in ./vimrc.vim
    "   It does not work when I put the lua <<EOF in ./vimrc.vim
    Plug 'neovim/nvim-lspconfig'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'glepnir/lspsaga.nvim'
    nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
    nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
    nnoremap <silent> K :Lspsaga hover_doc<CR>
    nnoremap <silent> gh :Lspsaga lsp_finder<CR>
    nnoremap <silent> gs :Lspsaga signature_help<CR>
    nnoremap <silent> gr :Lspsaga rename<CR>
    nnoremap <silent> gd :Lspsaga preview_definition<CR>

    " - Asynchronous Lint Engine (ALE)
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

    " - Viewer & Finder for LSP symbols and tags
    Plug 'liuchengxu/vista.vim'
    let g:vista_sidebar_position= 'vertical topleft'

    " - Tags management
    " TODO: Check if ctags is needed with LSP config.
    Plug 'ludovicchabant/vim-gutentags'
    set tags=./.tags;,.tags
    let g:gutentags_enabled = 1
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
    " put tags file to the tmpfs cache directory
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
    "   It is used mainly for refactorring.
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
    " enable trimmming of trailing whitespace
    let g:neoformat_basic_format_trim = 1

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

    " - AutoComplete
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'

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
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'joshdick/onedark.vim'
    Plug 'lifepillar/vim-solarized8'

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
    " - Vim plugin that shows keybindings in popup
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

    " - Underlines the word under the cursor
    Plug 'itchyny/vim-cursorword'
    let g:cursorword_delay = 400

    " - Visually select increasingly larger regions of text
    Plug 'terryma/vim-expand-region'
endif

" --- }

" -------------------- End Config --------------------

" Load plugins
call plug#end()
