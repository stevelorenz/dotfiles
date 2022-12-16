-- [[
-- About: Zuo's init.lua for Neovim
--        Neovim is currently my daily driver for software development (I work as a professional software engineer).
--        All configurations are made for my PERSONAL workflows.
--
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- ]]

local vim = vim

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		print("Installing packer.nvim...")
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

require("user.plugins")
-- If the packer.nvim is not installed, trigger packer sync and do NOT load other configuration directly.
if packer_bootstrap then
	require("packer").sync()
else
	require("user.autocommands")
	require("user.colorschemes")
	require("user.keymaps")
	require("user.options")
	require("user.plugins_config")

	if vim.g.neovide then
		require("neovide")
	end
end
