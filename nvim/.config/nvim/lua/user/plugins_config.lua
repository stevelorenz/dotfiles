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
		"go",
		"html",
		"javascript",
		"latex",
		"lua",
		"python",
		"ruby",
		"rust",
		"vim",
	},
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

----------------
--  gitsigns  --
----------------
require("gitsigns").setup()

-----------------
--  which-key  --
-----------------
require("which-key").setup({})

----------------------
--  nvim-autopairs  --
----------------------
require("nvim-autopairs").setup()

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
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
})

----------------
--  nvim-lsp  --
----------------
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

-- Setup Neovim's built-in LSP client
-- Following configurations are copied from the lspconfig README
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
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
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format{ async=true }<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"bashls",
	"clangd",
	"cmake",
	"erlangls",
	"gopls",
	"groovyls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"solargraph",
	"sqlls",
	"vimls",
}
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		flags = {},
	})
end

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

---------------
--  null-ls  --
---------------
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.diagnostics.shellcheck,
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
		{ name = "buffer", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "path", keyword_length = 3 },
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
require("marks").setup()

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
