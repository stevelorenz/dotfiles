" vim: set sw=4 ts=4 sts=4 et tw=100 foldmarker={,} foldlevel=0 foldmethod=marker:
"=========================================
" About: Zuo's Plugin Configuration for Neovim
"        Plugins are chosen ONLY for my PERSONAL workflow
" Maintainer: 相佐 (Zuo Xiang)
" Email: xianglinks@gmail.com
"
" Configurations for some new plugins using Lua are placed at the end of this file
" They are in a lua block (lua << EOF) and must be placed after `call plug#end()`
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
    " - Lean & mean status/tabline for vim that's light as air
    " TODO: Maybe replace airline with a lighter and faster alternative ?
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='onedark'

    " - Modern generic interactive finder and dispatcher for Vim and NeoVim
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

    " - Beakdown VIM's --startuptime output
    Plug 'tweekmonster/startuptime.vim'

    " - A tree explorer plugin for vim.
    Plug 'preservim/nerdtree'

    " - Adds file type icons to Vim plugins
    Plug 'ryanoasis/vim-devicons'

    " - Nvim Treesitter configurations and abstraction layer
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " - A collection of common lua functions
    Plug 'nvim-lua/plenary.nvim'

    " - Super fast git decorations
    Plug 'lewis6991/gitsigns.nvim'
endif
"  --- }


" --- General Editing ------------------------------------- {

if count(g:bundle_groups, 'general_editing')
    " - Handle surroundings
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'

    " - True Sublime Text style multiple selections for Vim
    " MARK: Neovim has the plan to support this feature, then this plugin is not needed.
    Plug 'mg979/vim-visual-multi'

    " - Underlines the word under the cursor
    Plug 'itchyny/vim-cursorword'
    let g:cursorword_delay = 400
endif
"  --- }


" --- General Programming --------------------------------- {

if count(g:bundle_groups, 'general_programming')
    " - Built-in lsp related plugins
    "   These plugins are configured with lua and current Configuration is in ./vimrc.vim
    "   It does not work when I put the lua <<EOF in ./vimrc.vim
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'

    " - LSP signature hint as you type
    Plug 'ray-x/lsp_signature.nvim'

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
    "   ctags are used when there is no LSP support
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

    " - Code search, view with edit mode
    "   It is used mainly for basic refactorring (in the era without LSP ;)).
    "   Maybe it's not needed anymore... check it
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
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'joshdick/onedark.vim'
    Plug 'lifepillar/vim-solarized8'

    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors
endif
" --- }


" --- Plugins Under Test ---------------------------------- {

if count(g:bundle_groups, 'test')
    " - Visually select increasingly larger regions of text
    Plug 'terryma/vim-expand-region'

    " - Better quickfix window
    Plug 'kevinhwang91/nvim-bqf'

    " - Autopairs for neovim
    Plug 'windwp/nvim-autopairs'

    " Vim syntax file & snippets for Docker's Dockerfile
    Plug 'ekalinin/Dockerfile.vim'

    " Displays available keybindings in popup
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
endif

" --- }
"
" Load plugins
call plug#end()

"==========================================
" Lua Plugin Configuration
"==========================================
" MARK: lua configs must be added after `call plug#end()`
" TODO: Check https://github.com/nanotee/nvim-lua-guide to learn how to configure nvim
" with lua modules to avoid embed lua scripts in vimscript files.
" {
lua <<EOF

-- Setup treesitter
require'nvim-treesitter.configs'.setup {
    --- only install langugages that I often use
    ensure_installed = {"c", "cpp", "go", "javascript", "latex", "lua", "python", "rust", "vim"},
    highlight = {
        enable = true,  -- false will disable the whole extension
        disable = {},   -- list of language that will be disabled
    },
    additional_vim_regex_highlighting = false,
}

-- Use nvim-lsp-installer to setup all installed LSP servers
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings
    local opts = { noremap=true, silent=true }
    -- Less key bindings, less problems... Should be less than ten...
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local server_opts = {
        on_attach = on_attach,
    }
    server:setup(server_opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Setup autocompletion
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require 'cmp'
cmp.setup {
    completion = {
        -- not perform autocompletion, use cmp.mapping.complete() to trigger completion.
        autocomplete = false,
        completeopt = 'menu,menuone,noinsert',
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    -- Currenly ONLY use LSP sources
    sources = {
        { name = 'nvim_lsp', keyword_length=3 },
    },
}

-- Setup lsp_signature
require "lsp_signature".setup()

-- Setup nvim-autopairs
require('nvim-autopairs').setup{}

-- Setup gitsigns
require('gitsigns').setup()
EOF

" Disable auto diagnostics entirely, use ale to do it on-demand
lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
" }
" -------------------- End Config --------------------
