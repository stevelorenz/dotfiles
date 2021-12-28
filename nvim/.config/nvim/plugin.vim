" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Zuo's Plugin Configuration for Neovim (v0.6.0)
"        Plugins are chosen ONLY for my PERSONAL workflow
"        In general, less plugins, less "problems".
"        The number of installed plugins should be MINIMIZED.
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
"=========================================

" - Use Vim-Plug Plugin Manager
call plug#begin(stdpath('data') . '/plugged')  " dir for plugin files

" -------------------- Start Config --------------------

" Inspired by spf13's vim config, installed plugins are divided into several groups.
" Remove element in the bundle_groups to disable a group of plugins.
if !exists('g:bundle_groups')
    let g:bundle_groups = ['general', 'general_editing', 'general_programming', 'snippet_autocomplete',
                \ 'c_cpp', 'python', 'rust', 'web_frontend', 'text', 'colorscheme', 'test']
endif

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')
    " - A collection of common lua functions
    Plug 'nvim-lua/plenary.nvim'

    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
    Plug 'liuchengxu/vim-clap'
    let g:clap_theme = 'material_design_dark'
    let g:clap_layout = { 'relative': 'editor' }

    " - Undo history visualizer
    Plug 'mbbill/undotree', { 'on':  'UndotreeToggle' }
    let g:undotree_SetFocusWhenToggle = 1

    "- This plugin adds indentation guides to all lines (including empty lines).
    Plug 'lukas-reineke/indent-blankline.nvim'

    " - Beakdown VIM's --startuptime output
    Plug 'tweekmonster/startuptime.vim'

    " - Adds file type icons to Vim plugins
    Plug 'ryanoasis/vim-devicons'

    " - Nvim Treesitter configurations and abstraction layer
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-refactor'

    " - Super fast git decorations
    Plug 'lewis6991/gitsigns.nvim'
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
    " - Built-in LSP related plugins
    "   These plugins are configured with lua and current Configuration is in ./vimrc.vim
    "   It does not work when I put the lua <<EOF in ./vimrc.vim
    "   nvim-lsp-installer is used to install language servers automatically (default in '~/.local/share/nvim/lsp_servers/')
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'

    " - LSP signature hint as you type
    Plug 'ray-x/lsp_signature.nvim'

    " - Viewer & Finder for LSP symbols and tags
    Plug 'liuchengxu/vista.vim'
    let g:vista_sidebar_position= 'vertical topleft'

    " - Tags management
    "   ctags are still used when there is no LSP support (or when LSP sucks ;))
    Plug 'ludovicchabant/vim-gutentags'
    set tags=./.tags;,.tags
    let g:gutentags_enabled = 1
    let g:gutentags_generate_on_new = 0
    let g:gutentags_generate_on_write = 0
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    let g:gutentags_ctags_tagfile = '.tags'
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

    " - Comment stuff out
    Plug 'tpope/vim-commentary'

    " - Simple template plugin
    Plug 'aperezdc/vim-template'
    " disable auto insertion
    let g:templates_no_autocmd = 1

    " - Run commands asynchronously
    Plug 'skywind3000/asyncrun.vim'

    " - Easy code formatting
    Plug 'sbdchd/neoformat',
    let g:neoformat_enabled_python = ['black', 'autopep8', 'docformatter']
    " enable trimmming of trailing whitespace
    let g:neoformat_basic_format_trim = 1
endif
" --- }


" --- Snippet and General Autocompletion ----------------------------- {

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
    " TODO: Use AI power ;) ? Check tabnine or copilot ? nvim-cmp has a source for tabnine
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
endif
" --- }


" --- Programming Language Specific ----------------------- {

" C, CPP {
if count(g:bundle_groups, 'c_cpp')
    " - Simplify Doxygen documentation
    Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp'] }
    let g:DoxygenToolkit_briefTag_funcName = "yes"
endif
" }

" Python {
if count(g:bundle_groups, 'python')
    " - Generate python docstring
    " 'make install' install doq package in a Python venv in the plugin's directory
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
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
endif
" }

" --- }


" --- Colorscheme ----------------------------------------- {

if count(g:bundle_groups, 'colorscheme')
    Plug 'navarasu/onedark.nvim'
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors
endif
" --- }


" --- Plugins Under Test ---------------------------------- {

if count(g:bundle_groups, 'test')
    " - Better quickfix window
    Plug 'kevinhwang91/nvim-bqf'

    " - Autopairs for neovim
    Plug 'windwp/nvim-autopairs'

    " - Vim syntax file & snippets for Docker's Dockerfile
    Plug 'ekalinin/Dockerfile.vim'

    " - Displays available keybindings in popup
    Plug 'folke/which-key.nvim'

    " - An asynchronous linter plugin
    Plug 'mfussenegger/nvim-lint'

    " - A blazing fast and easy to configure Neovim statusline written in Lua
    Plug 'nvim-lualine/lualine.nvim'

    " - A file explorer for neovim written in lua
    Plug 'kyazdani42/nvim-tree.lua'

endif

" --- }
"
" Load plugins
call plug#end()

"==========================================
" Lua Plugin Configuration
"==========================================
" MARK: For Vim-Plug, lua configs MUST be added after `call plug#end()`
" {

lua require('plugin')

" }

" -------------------- End Config --------------------
