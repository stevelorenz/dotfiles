--
-- keymaps.lua
-- About: Zuo's Keymap Configuration for Neovim
--

local vim = vim

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Use , as the leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

--- Normal Mode ---

-- Change window size
keymap("n", "w=", ":resize +3<CR>", opts)
keymap("n", "w-", ":resize -3<CR>", opts)
keymap("n", "w.", ":vertical resize +3<CR>", opts)
keymap("n", "w,", ":vertical resize -3<CR>", opts)

-- Toggle spell checking
keymap("n", "<leader>ss", ":setlocal spell!<CR>", opts)

keymap("n", "<C-S>", ":update<CR>", opts)

-- Ctrl + left/right is used to switch workspaces on MacOS
keymap("n", "<A-left>", ":bprevious<CR>", opts)
keymap("n", "<A-right>", ":bnext<CR>", opts)
keymap("n", "<leader>bd", ":bp <BAR> bd # <CR>", opts)

keymap("n", "<leader>c", ":copen<CR>", opts)

keymap("n", "<F1>", ":echo<CR>", opts)
keymap("n", "<F6>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<F8>", ":UndotreeToggle<CR>", opts)
keymap("n", "<F10>", ":Vista!!<CR>", opts)

--- Insert Mode ---

-- Press jk fast to enter normal mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "<C-S>", "<C-O>:update<CR>", opts)
