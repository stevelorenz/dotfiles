-- Neovide (No Nonsense Neovim Client in Rust) Configuration
-- NOTE: Used as my default Neovim GUI. Tested on Linux and MacOS (installed with Homebrew)

local vim = vim

vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_fullscreen = false
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_theme = "auto"

--------------------------
--  Font Configuration  --
--------------------------

vim.g.gui_font_default_size = 24
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code Light"

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

-- Set the default value on startup
ResetGuiFont()

local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "i" }, "<C-=>", function()
	ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
	ResizeGuiFont(-1)
end, opts)
