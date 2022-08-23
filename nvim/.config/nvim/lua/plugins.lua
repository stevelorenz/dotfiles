-- [[
-- About: Zuo's Plugin Configuration for Neovim (v0.6.0)
--        Plugins are chosen ONLY for my PERSONAL workflow
--        In general, less plugins, less "problems".
--        The number of installed plugins should be MINIMIZED.
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- Last update date: 07.2022 (Try to check and update plugins every month)
-- ]]

local vim = vim

---------------------------------------------
--  Vim-Plug Configuration with Vimscript  --
---------------------------------------------

vim.cmd([[
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

	" Portable package manager for Neovim
    Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'

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

	" Neovim motions on speed!
	Plug 'phaazon/hop.nvim'
endif

" --- }
"
" Load all plugins
call plug#end()
" -------------------- End Config --------------------
]])

-------------------------------------
--  Plugin Configuration with Lua  --
-------------------------------------

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	-- Install only modules for the languages I use frequently
	ensure_installed = { "bash", "c", "cpp", "go", "javascript", "latex", "lua", "python", "ruby", "rust", "vim" },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},
	additional_vim_regex_highlighting = false,
	-- Use built-in "smart select" feature. It's an alternative for the vim-expand-region plugin
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
})

-- Setup mason.nvim and mason-lspconfig.nvim

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
})

-- Setup Neovim's built-in LSP client
-- Following configurations are copied from the lspconfig README
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers =
{ "bashls", "clangd", "cmake", "gopls", "pyright", "rust_analyzer", "solargraph", "sqls", "sumneko_lua", "vimls" }
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	})
end

-- Setup autocompletion
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require("cmp")
cmp.setup({
	completion = {
		-- Auto-completion can be disabled here and trigger completion manually with C-Space
		-- autocomplete = false,
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
		-- (b)ack and (f)orward documentation
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	},
	-- Currenly ONLY use LSP and buffer sources
	sources = {
		{ name = "buffer", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "path", keyword_length = 3 },
	},
})

-- nvim-cmp menu appearance
-- Use vscode dark+ theme
vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])

-- Setup lsp_signature
require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})

-- Setup nvim-autopairs
require("nvim-autopairs").setup()

-- Setup gitsigns
require("gitsigns").setup()

-- Setup lualine
require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
	-- Enable traditional bufferline
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
})

-- Setup indent_blankline
require("indent_blankline").setup({
	show_current_context_start = true,
})

-- Setup which-key
require("which-key").setup({})

-- Setup nvim-tree
require("nvim-tree").setup({})

-- Setup null-ls
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.diagnostics.shellcheck,
	},
})

-- Setup yode-nvim
require("yode-nvim").setup({})

-- Setup neogen
require("neogen").setup({
	enabled = true,
	languages = {
		python = {
			template = {
				-- "google_docstrings"
				-- "numpydoc"
				-- "reST"
				annotation_convention = "reST",
			},
		},
	},
})

-- wilder.nvim
local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer({
		highlighter = wilder.basic_highlighter(),
		left = { " ", wilder.popupmenu_devicons() },
		right = { " ", wilder.popupmenu_scrollbar() },
	})
)

-- Here is just a tmp workaround before I migrate the plugin manager to a lua-based one...
vim.cmd([[
if count(g:bundle_groups, 'test')
lua << EOF
local vim = vim

-- trouble.nvim
require("trouble").setup({})

-- lspsagal.nvim
local saga = require("lspsaga")
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
require("colorizer").setup()

-- hop.nvim
require("hop").setup()
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})

EOF
endif
]])
