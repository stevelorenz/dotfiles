--
-- plugins_config.lua
-- About: Configuration for installed plugins
--

local vim = vim

---------------
--  lualine  --
---------------
require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
})

------------------
--  Bufferline  --
------------------
vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		separator_style = "padded_slant",
	},
})

-----------------
--  Telescope  --
-----------------
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

----------------
--  undotree  --
----------------
vim.g.undotree_SetFocusWhenToggle = 1

------------------------
--  indent_blankline  --
------------------------
require("indent_blankline").setup({
	char = "┊",
	show_trailing_blankline_indent = false,
	show_current_context_start = true,
})

------------------
--  treesitter  --
------------------
require("nvim-treesitter.configs").setup({
	-- Install only modules for the languages I use frequently
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"gitignore",
		"go",
		"haskell",
		"html",
		"javascript",
		"json",
		"latex",
		"lua",
		"markdown",
		"python",
		"ruby",
		"rust",
		"vim",
		"yaml",
	},
	auto_install = true,
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
			node_decremental = "<S-TAB>",
			node_incremental = "<TAB>",
			scope_incremental = false,
		},
	},
})

----------------
--  gitsigns  --
----------------
require("gitsigns").setup({})

-----------------
--  which-key  --
-----------------
require("which-key").setup({})

----------------------
--  nvim-autopairs  --
----------------------
require("nvim-autopairs").setup({})

-----------------
--  nvim-tree  --
-----------------
require("nvim-tree").setup({})

----------------
--  nvim-bqf  --
----------------
require("bqf").setup({})

-------------
--  Mason  --
-------------
-- Following order is required: mason -> mason-lspconfig -> lspconfig
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
})

----------------
--  nvim-lsp  --
----------------
-- Setup Neovim's built-in LSP client
-- Configs are copied and adapted from lspconfig's README (May be outdated...)

-- LSP servers that use the default setup, namely without any customized configs
local servers_default = {
	"bashls",
	"clangd",
	"cmake",
	"erlangls",
	"gopls",
	"groovyls",
	"hls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"solargraph",
	"sqlls",
	"vimls",
}
for _, lsp in pairs(servers_default) do
	require("lspconfig")[lsp].setup({})
end

-- Global mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

----------------------
--  fidget.nvim  -  --
----------------------
require("fidget").setup({
	sources = {
		-- erlangls is a little bit TMI...
		erlangls = {
			ignore = true,
		},
	},
})

---------------------
--  lsp_signature  --
---------------------
require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})

--------------
--  neogen  --
--------------
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

-----------------
--  ultisnips  --
-----------------
vim.cmd([[
	let g:UltiSnipsExpandTrigger = "<leader><tab>"
	let g:UltiSnipsListSnippets = "<f9>"
	let g:UltiSnipsJumpForwardTrigger = "<leader><tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<leader><s-tab>"
	let g:UltiSnipsEditSplit = "vertical"
	" searching paths
	let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'custom_snippets']
]])

----------------
--  nvim-cmp  --
----------------
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require("cmp")
cmp.setup({
	completion = {
		-- Uncomment the next line to disable autocompletion (Trigger completion manually)
		-- autocomplete = false,
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<A-space>"] = cmp.mapping.complete(),
		["<A-e>"] = cmp.mapping.close(),
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
		{ name = "buffer",   keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "path",     keyword_length = 3 },
	},
})

---------------
--  trouble  --
---------------
require("trouble").setup({})

----------------
--  lspsaga  --
----------------
require("lspsaga").setup({
	-- code action prompt does not work properly for e.g. bash sources...
	code_action_lightbulb = {
		enable = false,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
})

------------------
--  marks.nvim  --
------------------
require("marks").setup({})

----------------------
--  nvim-lastplace  --
----------------------
require("nvim-lastplace").setup({})

----------------
--  nvim-ufo  --
----------------
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

--------------------------
--  todo-comments.nvim  --
--------------------------
require("todo-comments").setup({})

-----------------------
--  mini.animate  -  --
-----------------------
require('mini.animate').setup({})
