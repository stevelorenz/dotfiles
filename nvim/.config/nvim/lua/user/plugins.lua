-- [[
-- About: Zuo's Plugin Configuration for Neovim
--        Plugins are chosen ONLY for my PERSONAL workflow.
--        In general, less plugins, less "problems".
--        The number of installed plugins should be MINIMIZED.
--        This file ONLY contains the list of plugins, configuration is located in ./plugins_config.lua
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- ]]

local vim = vim

return require("lazy").setup({

	-- A collection of common lua functions
	{ "nvim-lua/plenary.nvim" },

	-- A blazing fast and easy to configure Neovim status line written in Lua
	{ "nvim-lualine/lualine.nvim" },

	-- A snazzy buffer line for Neovim
	{ "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Find, Filter, Preview, Pick. All lua, all the time
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- File Browser extension for telescope.nvim
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	-- Undo history visualizer
	{ "mbbill/undotree" },

	-- This plugin adds indentation guides to all lines (including empty lines)
	{ "lukas-reineke/indent-blankline.nvim" },

	-- Beakdown VIM's -- startuptime output
	{ "tweekmonster/startuptime.vim" },

	-- Adds file type icons to Vim plugins
	{ "nvim-tree/nvim-web-devicons" },

	-- Nvim Treesitter configurations and abstraction layer
	{ { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" } },

	-- Syntax aware text-objects, select, move, swap, and peek support
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	--
	-- Nvim-treesitter-context
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- Super fast git decorations
	{ "lewis6991/gitsigns.nvim" },

	-- Displays available keybindings in popup
	{ "folke/which-key.nvim" },

	-- Autopairs for neovim
	{ "windwp/nvim-autopairs" },

	-- A file explorer for neovim written in lua
	{ "kyazdani42/nvim-tree.lua" },

	-- Better quickfix(bqf) window
	{ "kevinhwang91/nvim-bqf" },

	-- Handle surroundings
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },

	-- Configs for Nvim built-in LSP support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Portable LSP server/linter manager for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},

	-- Portable package manager for Neovim that runs everywhere Neovim runs.
	-- Easily install and manage LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},

	-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
	{
		"williamboman/mason-lspconfig.nvim",
	},

	-- Standalone UI for nvim-lsp progress
	{ "j-hui/fidget.nvim" },

	-- LSP signature
	{ "ray-x/lsp_signature.nvim" },

	-- Comment stuff out
	{ "tpope/vim-commentary" },

	-- Easy code formatting
	{ "sbdchd/neoformat" },

	-- A better annotation/documentation generator
	{ "danymat/neogen" },

	-- Code snippets
	{ "honza/vim-snippets", dependencies = { { "SirVer/ultisnips" } } },

	-- A completion plugin for neovim coded in Lua.
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
		},
	},

	-- A pretty list for showing diagnostics, references, telescope results
	{ "folke/trouble.nvim" },

	-- Lspsaga
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
	},

	-- A better user experience for viewing and interacting with Vim marks
	{ "chentoast/marks.nvim" },

	-- A text searching plugin mimics Ctrl-Shift-F on Sublime Text 2
	{ "dyng/ctrlsf.vim" },

	-- Catppuccin colorscheme
	{ "catppuccin/nvim" },

	-- A Lua rewrite of vim-lastplace
	{ "ethanholz/nvim-lastplace" },

	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
	{ "sindrets/diffview.nvim" },

	-- Not UFO in the sky, but an ultra fold in Neovim
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

	-- Neovim dashboard
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Zen mode
	{ "folke/zen-mode.nvim" },

	-- Dims inactive portions of the code you're editing using Treesitter
	{ "folke/twilight.nvim" },

	-- Highlight, list and search todo comments in your projects
	{ "folke/todo-comments.nvim" },

	-- Automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
	{ "RRethy/vim-illuminate" },

	-- Maintained fork of the fastest Neovim colorizer
	{ "NvChad/nvim-colorizer.lua" },

	-- Tokyonight: a clean, dark Neovim theme written in Lua
	{ "folke/tokyonight.nvim" },

	-- A fancy, configurable, notification manager for NeoVim
	{ "rcarriga/nvim-notify" },

	-- Heuristically set buffer options
	{ "tpope/vim-sleuth" },

	-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu
	-- {
	-- 	"folke/noice.nvim",
	-- 	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	-- },

	---------------------------
	--  mini.nvim collection --
	---------------------------
	-- Animate common Neovim actions
	{ "echasnovski/mini.animate" },

	-- Work with trailing whitespace
	{ "echasnovski/mini.trailspace" },
})
