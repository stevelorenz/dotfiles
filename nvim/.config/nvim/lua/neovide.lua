-- Neovide (GUI for Neovim) configuration
local vim = vim

vim.g.neovide_transparency = 1.0
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = "railgun"
-- vim.g.neovide_profiler = true

vim.g.gui_font_default_size = 18
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Cascadia Code PL SemiLight"

RefreshGuiFont = function()
	vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
	vim.g.gui_font_size = vim.g.gui_font_size + delta
	RefreshGuiFont()
end

ResetGuiFont = function()
	vim.g.gui_font_size = vim.g.gui_font_default_size
	RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "i" }, "<C-=>", function()
	ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
	ResizeGuiFont(-1)
end, opts)
