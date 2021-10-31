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
    " TODO: Maybe replace airline with a lighter and faster alternative ?
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
    " TODO: Check if ctags is still needed with LSP config.
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
    "   It is used mainly for basic refactorring (in the era without LSP ;)).
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
    Plug 'sbdchd/neoformat',
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

    " - Highlight matched tags
    Plug 'Valloric/MatchTagAlways', { 'for': ['xml', 'html', 'css', 'javascript'] }
endif
" }

" --- }


" --- Documentation and Writing --------------------------- {

if count(g:bundle_groups, 'text')
endif

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

    " - LSP signature hint as you type
    Plug 'ray-x/lsp_signature.nvim'

    " - Dashboard
    Plug 'glepnir/dashboard-nvim'

    " - Better quickfix window
    Plug 'kevinhwang91/nvim-bqf'

    " - Autopairs for neovim
    Plug 'windwp/nvim-autopairs'

    " Vim syntax file & snippets for Docker's Dockerfile
    Plug 'ekalinin/Dockerfile.vim'

endif

" --- }
"
" Load plugins
call plug#end()

"==========================================
" Lua Plugin Configuration
"==========================================
" MARK: lua configs must be added after `call plug#end()`
" {
lua <<EOF
-- setup nvim treesitter
require'nvim-treesitter.configs'.setup {
    --- only install langugages that I often use
    ensure_installed = {"c", "cpp", "go", "javascript", "latex", "lua", "python", "rust"},
    highlight = {
        enable = true,  -- false will disable the whole extension
        disable = {},   -- list of language that will be disabled
    },
}

-- setup built-in lsp client support
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- setup lsp servers with nvim-lsp_installer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- setup lsp saga
local saga = require 'lspsaga'
saga.init_lsp_saga()

-- setup autocompletion
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
    sources = {
        { name = 'nvim_lsp', keyword_length=3 },
    },
}

-- setup lsp_signature
require "lsp_signature".setup()

-- setup nvim-autopairs
require('nvim-autopairs').setup{}
EOF

" disable diagnostics entirely, use ale to do it on-demand
lua vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
" }
" -------------------- End Config --------------------

