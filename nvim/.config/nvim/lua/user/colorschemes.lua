--
-- colorscheme.lua
--

local vim = vim

local ok, _ = pcall(require, "catppuccin")

if ok then
	-- I like catppuccin theme and use it for terminal, Gnome, Neovim and so on...
	vim.cmd.colorscheme("catppuccin")

	-- Catppuccin
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
			dashboard = true,
			gitsigns = true,
			indent_blankline = { enabled = true },
			lsp_trouble = true,
			mason = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			telescope = true,
			treesitter = true,
			which_key = true,
		},

		styles = {},
	})
else
	-- Fall back to built-in slate
	vim.cmd.colorscheme("slate")
end
