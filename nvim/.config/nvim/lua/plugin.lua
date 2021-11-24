--
-- plugin.lua
--
-- About: Zuo's Plugin Configuration for Neovim
--        Plugins are chosen ONLY for my PERSONAL workflow
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
--

-- Setup treesitter
require "nvim-treesitter.configs".setup {
	-- Install only modules for the languages I use frequently
	ensure_installed = {"c", "cpp", "go", "javascript", "latex", "lua", "python", "rust", "vim"},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {} -- list of language that will be disabled
	},
	additional_vim_regex_highlighting = false,
	-- Use built-in "smart select" feature
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>"
		}
	}
}

-- Use nvim-lsp-installer to setup all installed LSP servers
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Key mappings
	local opts = {noremap = true, silent = true}
	-- Less key bindings, less problems... Should be less than ten...
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(
function(server)
	local server_opts = {
		on_attach = on_attach
	}
	server:setup(server_opts)
	vim.cmd [[ do User LspAttachBuffers ]]
end
)

-- Setup autocompletion
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require "cmp"
cmp.setup {
	completion = {
		-- Do not perform autocompletion, use cmp.mapping.complete() to trigger completion.
		autocomplete = false,
		completeopt = "menu,menuone,noinsert"
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
		}
	},
	-- Currenly ONLY use LSP sources
	sources = {
		{name = "nvim_lsp", keyword_length = 3}
	}
}

-- Setup lsp_signature
require "lsp_signature".setup()

-- Setup nvim-autopairs
require("nvim-autopairs").setup {}

-- Setup gitsigns
require("gitsigns").setup()
