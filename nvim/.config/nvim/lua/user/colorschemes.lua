--
-- colorscheme.lua
--

local vim = vim
vim.cmd.colorscheme "catppuccin"

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
