-- [[
-- About: Zuo's usein Configuration for Neovim
--        useins are chosen ONLY for my PERSONAL workflow.
--        In general, less plugins, less "problems".
--        The number of installed plugins should be MINIMIZED.
--        This file ONLY contains the list of plugins, configuration is located in ./plugins_config.lua
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- Last update date: 2022.12.16 (Migrate from vim-plug to packer.nvim)
-- ]]

local vim = vim

-- Run PackerSync when you save the plugins.lua
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

return require("packer").startup(function(use)
	-- let packer.nvim manage itself
	use("wbthomason/packer.nvim")

	-- A collection of common lua functions
	use("nvim-lua/plenary.nvim")

	-- A blazing fast and easy to configure Neovim statusline written in Lua
	use("nvim-lualine/lualine.nvim")

	-- A snazzy bufferline for Neovim
	use({ "akinsho/bufferline.nvim", tag = "v4.1.0", requires = "nvim-tree/nvim-web-devicons" })

	-- Find, Filter, Preview, Pick. All lua, all the time
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Undo history visualizer
	use("mbbill/undotree")

	-- This plugin adds indentation guides to all lines (including empty lines)
	use({ "lukas-reineke/indent-blankline.nvim", tag = "v2.20.*" })

	-- Beakdown VIM's --startuptime output
	use("tweekmonster/startuptime.vim")

	-- Adds file type icons to Vim plugins
	use("nvim-tree/nvim-web-devicons")

	-- Nvim Treesitter configurations and abstraction layer
	use({
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.9.0",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	-- Super fast git decorations
	use("lewis6991/gitsigns.nvim")

	-- Displays available keybindings in popup
	use("folke/which-key.nvim")

	-- Autopairs for neovim
	use("windwp/nvim-autopairs")

	-- A file explorer for neovim written in lua
	use("kyazdani42/nvim-tree.lua")

	-- Better quickfix(bqf) window
	use("kevinhwang91/nvim-bqf")

	-- Handle surroundings
	use("tpope/vim-repeat")
	use("tpope/vim-surround")

	-- Configs for Nvim built-in LSP support
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Portable LSP server/linter manager for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})

	-- Portable package manager for Neovim that runs everywhere Neovim runs.
	-- Easily install and manage LSP servers, DAP servers, linters, and formatters
	use({
		"williamboman/mason.nvim",
		tags = "1.2.1",
		run = ":MasonUpdate",
	})

	-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
	use({
		"williamboman/mason-lspconfig.nvim",
		tags = "1.7.1",
	})

	-- Standalone UI for nvim-lsp progress
	use({ "j-hui/fidget.nvim", tag = "legacy" })

	-- LSP signature
	use("ray-x/lsp_signature.nvim")

	-- Comment stuff out
	use("tpope/vim-commentary")

	-- Easy code formatting
	use("sbdchd/neoformat")

	-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	use("jose-elias-alvarez/null-ls.nvim")

	-- A better annotation/documentation generator
	use("danymat/neogen")

	-- Code snippets
	use({ "honza/vim-snippets", requires = { { "SirVer/ultisnips" } } })

	-- A completion plugin for neovim coded in Lua.
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
		},
	})

	-- A pretty list for showing diagnostics, references, telescope results
	use("folke/trouble.nvim")

	-- Lspsaga
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})

	-- A better user experience for viewing and interacting with Vim marks
	use("chentoast/marks.nvim")

	-- A text searching plugin mimics Ctrl-Shift-F on Sublime Text 2
	use("dyng/ctrlsf.vim")

	-- Catppuccin colorscheme
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- A Lua rewrite of vim-lastplace
	use({ "ethanholz/nvim-lastplace" })

	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
	use({ "sindrets/diffview.nvim" })

	-- Not UFO in the sky, but an ultra fold in Neovim
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

	-- Neovim dashboard
	use({
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Zen mode
	use({ "folke/zen-mode.nvim" })

	-- Highlight, list and search todo comments in your projects
	use({ "folke/todo-comments.nvim" })
end)
