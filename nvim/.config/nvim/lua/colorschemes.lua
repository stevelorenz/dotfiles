--
-- colorscheme.lua
--

local vim = vim

-- catppuccin
require("catppuccin").setup({
	-- Pre-compile the configuration and store it in nvim's cache
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
		suffix = "_compiled",
	},

	integration = {
		lsp_saga = true,
	},

	styles = {},
})
vim.g.catppuccin_flavour = "mocha"

-- onedark
require("onedark").setup({ style = "dark" })

-- tokyonight
vim.g.tokyonight_style = "storm"

vim.cmd([[
set background=dark
colorscheme catppuccin
" colorscheme onedark
" colorscheme tokyonight
]])
