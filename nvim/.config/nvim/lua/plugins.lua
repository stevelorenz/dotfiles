--
-- plugins.lua
--
-- About: Zuo's Lua Plugin Configuration for Neovim
--        Plugins are chosen ONLY for my PERSONAL workflow
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
--

local vim = vim

-- Setup treesitter
require("nvim-treesitter.configs").setup({
	-- Install only modules for the languages I use frequently
	ensure_installed = { "c", "cpp", "go", "javascript", "latex", "lua", "python", "rust", "vim" },
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

-- Setup Neovim's built-in LSP client
-- Use nvim-lsp-installer to install LSP servers. The installer must be setup
-- BEFORE ALL lspconfig configurations.
require("nvim-lsp-installer").setup({})

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
local servers = { "bashls", "clangd", "gopls", "pyright", "rust_analyzer", "sumneko_lua" }
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
		theme = "auto",
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
