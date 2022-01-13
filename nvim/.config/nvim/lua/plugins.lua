--
-- plugins.lua
--
-- About: Zuo's Lua Plugin Configuration for Neovim
--        Plugins are chosen ONLY for my PERSONAL workflow
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
--

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

-- Setup LSP servers and the built-in LSP client
-- Use nvim-lsp-installer to install and setup all LSP servers
-- reference: https://github.com/neovim/nvim-lspconfig/blob/master/README.md
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	-- Enable LSP completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Key mappings
	local opts = { noremap = true, silent = true }
	-- Less key bindings, less problems... Should be less than ten...
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
	}

	-- Custom options for special language servers
	if server.name == "clangd" then
		-- disable automatic addition of #includes
		-- usually the required bundled the header file is already included...
		-- I need to manually remove them to avoid duplication and wrong includes...
		opts.cmd = { "clangd", "-header-insertion=never" }
	end

	server:setup(opts)
end)

-- Setup autocompletion
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require("cmp")
cmp.setup({
	completion = {
		-- Disable auto-completion and trigger completion with C-Space
		autocomplete = false,
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	-- Currenly ONLY use LSP and buffer sources
	sources = {
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
	},
})

-- Setup lsp_signature
require("lsp_signature").setup()

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
