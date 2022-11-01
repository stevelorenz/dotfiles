--
-- colorscheme.lua
--

local vim = vim

-- catppuccin
require("catppuccin").setup({
	flavor = "mocha",
	-- Pre-compile the configuration and store it in nvim's cache
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
		suffix = "_compiled",
	},

	integration = {
		cmp = true,
		gitsigns = true,
	},

	styles = {},
})

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
