-- [[
-- About: Zuo's init.lua for Neovim
--        Neovim is currently my daily driver for software development (I work as a professional software engineer).
--        All configurations are made for my PERSONAL workflows.
--
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- ]]

-- Enable the new faster lua loader using byte-compilation
vim.loader.enable()

----------------------------
--  Check Neovim version  --
----------------------------

local version_is_ok = true
local nvim_version = vim.version()
if nvim_version.major >= 1 then
	version_is_ok = false
elseif nvim_version.minor < 10 then
	version_is_ok = false
end
if not version_is_ok then
	vim.api.nvim_err_writeln(
		"This configuration requires Neovim with the version >= 0.10.0 and < 1.0.0. (Type any key to exit!)"
	)
	vim.fn.getchar()
	vim.cmd("qa!")
end

----------------------------------------------
--  Bootstrap Neovim with a plugin manager  --
----------------------------------------------

local ensure_plugin_manager = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
		vim.opt.rtp:prepend(lazypath)
		return true
	end

	vim.opt.rtp:prepend(lazypath)
	return false
end
local plugin_manager_bootstrap = ensure_plugin_manager()

-- Enable fast lua module loader (available since 0.9)
vim.loader.enable()

-- This module should install all plugins during bootstrapping
require("user.plugins")

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart Neovim, and then it will work.
if plugin_manager_bootstrap then
	print("==================================")
	print("    Plugins are being installed/synced...")
	print("    Wait until the plugin manager completes,")
	print("       then restart Neovim")
	print("==================================")
else
	require("user.autocommands")
	require("user.colorschemes")
	require("user.keymaps")
	require("user.options")
	require("user.plugins_config")

	-- Optional GUI clients
	if vim.g.neovide then
		require("user.neovide")
	end
end
