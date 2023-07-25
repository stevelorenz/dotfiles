-- [[
-- About: Zuo's init.lua for Neovim
--        Neovim is currently my daily driver for software development (I work as a professional software engineer).
--        All configurations are made for my PERSONAL workflows.
--
-- Maintainer: 相佐 (Zuo Xiang)
-- Email: xianglinks@gmail.com
-- ]]

local vim = vim
-- local os_name = vim.loop.os_uname().sysname

----------------------------
--  Check Neovim Version  --
----------------------------

local version_is_ok = true
local nvim_version = vim.version()
if nvim_version.major >= 1 then
	version_is_ok = false
elseif nvim_version.minor < 9 then
	version_is_ok = false
end
if not version_is_ok then
	vim.api.nvim_err_writeln(
		"This configuration requires Neovim with the version >= 0.9.0 and < 1.0.0. (Type any key to exit!)"
	)
	vim.fn.getchar()
	vim.cmd("qa!")
end

------------------------------------------------------------
--  Bootstrap Neovim with plugins managed by packer.nvim  --
------------------------------------------------------------

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

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if packer_bootstrap then
	require("packer").sync()
	print("==================================")
	print("    Plugins are being installed/synced...")
	print("    Wait until Packer completes,")
	print("       then restart neovim")
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
