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

	-- Find, Filter, Preview, Pick. All lua, all the time
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Undo history visualizer
	use("mbbill/undotree")

	-- This plugin adds indentation guides to all lines (including empty lines)
	use("lukas-reineke/indent-blankline.nvim")

	-- Beakdown VIM's --startuptime output
	use("tweekmonster/startuptime.vim")

	-- Adds file type icons to Vim plugins
	use("kyazdani42/nvim-web-devicons")

	-- Nvim Treesitter configurations and abstraction layer
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
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

	-- Portable LSP server/linter manager for Neovim
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Quickstart configs for Nvim LSP
	use("neovim/nvim-lspconfig")

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
	use { "honza/vim-snippets",
		requires = { { "SirVer/ultisnips" } } }

	-- A completion plugin for neovim coded in Lua.
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")

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
end)
