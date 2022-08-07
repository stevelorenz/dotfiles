" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Zuo's Plugin Configuration for Neovim (v0.6.0)
"        Plugins are chosen ONLY for my PERSONAL workflow
"        In general, less plugins, less "problems".
"        The number of installed plugins should be MINIMIZED.
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
" Last update date: 07.2022 (Try to check and update plugins every month)
"=========================================

" - Use Vim-Plug Plugin Manager
" TODO: Check packer.nvim, the de facto standard packet manager for Neovim
call plug#begin(stdpath('data') . '/plugged')  " dir for plugin files

" -------------------- Start Config --------------------

" Inspired by spf13's vim config, installed plugins are divided into several groups.
" Remove element in the bundle_groups to disable a group of plugins.
if !exists('g:bundle_groups')
    let g:bundle_groups = [
                \ 'general',
                \ 'general_editing',
                \ 'general_programming',
                \ 'snippet_autocomplete',
                \ 'c_cpp',
                \ 'python',
                \ 'rust',
                \ 'web_frontend',
                \ 'colorscheme',
                \ 'test'
                \]
endif

" --- Helpers --------------------------------------------- {

function UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
endfunction

" }

" --- General --------------------------------------------- {

if count(g:bundle_groups, 'general')
    " - A collection of common lua functions
    Plug 'nvim-lua/plenary.nvim'

    " - A blazing fast and easy to configure Neovim statusline written in Lua
    Plug 'nvim-lualine/lualine.nvim'

    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
    " TODO: Check if telescope.nvim is a better alternative
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
    Plug 'kyazdani42/nvim-web-devicons'

    " - Nvim Treesitter configurations and abstraction layer
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-refactor'

    " - Super fast git decorations
    Plug 'lewis6991/gitsigns.nvim'

    " - Displays available keybindings in popup
    Plug 'folke/which-key.nvim'

    " - Autopairs for neovim
    Plug 'windwp/nvim-autopairs'

    " - A file explorer for neovim written in lua
    Plug 'kyazdani42/nvim-tree.lua'

    " - Better quickfix window
    Plug 'kevinhwang91/nvim-bqf'

    " - A more adventurous wildmenu
    Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
endif
"  --- }


" --- General Editing ------------------------------------- {

if count(g:bundle_groups, 'general_editing')
    " - Handle surroundings
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

    " - Focus on important part of the code. Very nice !
    Plug 'hoschi/yode-nvim'
endif
"  --- }


" --- General Programming --------------------------------- {

if count(g:bundle_groups, 'general_programming')
    " - Built-in LSP related plugins
    "   These plugins are configured with lua and current Configuration is in ./vimrc.vim
    "   It does not work when I put the lua <<EOF in ./vimrc.vim
    "   nvim-lsp-installer is used to install language servers automatically (default in '~/.local/share/nvim/lsp_servers/')
    Plug 'neovim/nvim-lspconfig'

    " - TODO: Migrate to mason.nvim, which is the portable package manager written by the same
    "   plugin author
    Plug 'williamboman/nvim-lsp-installer'

    " - LSP signature hint as you type
    "   TODO: Check if nvim-cmp has native support for signature, so this plugin is not needed.
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
    " do not pollute the source code directory
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
    "   TODO: Check if this needed when LSP supports formatting
    Plug 'sbdchd/neoformat',
    let g:neoformat_enabled_python = ['black']
    " enable trimmming of trailing whitespace
    let g:neoformat_basic_format_trim = 1

    " - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    Plug 'jose-elias-alvarez/null-ls.nvim'

    " - A better annotation generator.
    Plug 'danymat/neogen'
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
    " MARK: nvim-cmp can impact the autocompletion of the cmdline (wildmenu). Check it if wildmenu
    " does not work
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
endif
" --- }


" MARK: Thanks to LSP, most language-specific plugins are now UNNECESSARY.
" --- Programming Language Specific ----------------------- {

" C, CPP {
if count(g:bundle_groups, 'c_cpp')
endif
" }

" Python {
if count(g:bundle_groups, 'python')
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
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    Plug 'catppuccin/nvim', {'as': 'catppuccin', 'do': 'CatppuccinCompile'}
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'navarasu/onedark.nvim'
endif
" --- }


" --- Plugins Under Test ---------------------------------- {

if count(g:bundle_groups, 'test')
    " - Vim syntax file & snippets for Docker's Dockerfile
    Plug 'ekalinin/Dockerfile.vim'

    " - A grammer checker
    "   MARK: Need to use it to double-check my PhD dissertation...
    "   It is a useful plugin to help writing
    Plug 'rhysd/vim-grammarous'

    " - A pretty list for showing diagnostics, references, telescope results,
    "   quickfix and location lists to help you solve all the trouble
    "   your code is causing.
    Plug 'folke/trouble.nvim'

    " A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

    " A high-performance color highlighter
    Plug 'norcalli/nvim-colorizer.lua'
    set termguicolors " required by nvim-colorizer.lua
    " color: #558817
    " color: #8080ff
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
lua require('plugins')

" Lua configuration for plugins under test
" These configurations should be moved to ./lua/plugins.lua if they pass the test
if count(g:bundle_groups, 'test')

lua << EOF
    -- trouble.nvim
    require("trouble").setup({})

    -- lspsagal.nvim
    local saga = require 'lspsaga'
    saga.init_lsp_saga({
        -- code action prompt does not work properly for e.g. bash sources...
        code_action_lightbulb = {
            enable = false,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
    })

    -- nvim-colorizer.lua
    require('colorizer').setup()
EOF

endif
" }

" -------------------- End Config --------------------