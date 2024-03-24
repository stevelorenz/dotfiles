--
-- options.lua
-- About: Zuo's Options Configuration for Neovim
--

local utils = require("user.utils")

-- Check OS type
vim.g.is_win = (utils.has("win32") or utils.has("win64")) and true or false
vim.g.is_linux = (utils.has("unix") and (not utils.has("macunix"))) and true or false
vim.g.is_mac = utils.has("macunix") and true or false

-- Globals
vim.g.logging_level = "info"
vim.g.did_install_default_menus = 1 -- do not load menu
vim.g.loaded_sql_completion = 1     -- disable broken SQL omni completion

-- Less options, less problems...
local options = {
	autowrite = true, -- enable auto write
	backspace = "indent,eol,start",
	backup = false, -- do not create backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	colorcolumn = { "80", "120" },
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	confirm = true, -- Ask for confirmation when handling unsaved or read-only files
	cursorcolumn = true, -- highlight the current column
	cursorline = true, -- highlight the current line
	emoji = true,
	encoding = "utf-8",
	fileencoding = "utf-8", -- the encoding written to a file
	fileformats = { "unix" },
	foldmethod = "indent", -- use indent as the DEFAULT folding method. This method does not require treesitter
	foldenable = false, -- Dot not form folds when opening the file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	laststatus = 3, -- Use global statusline
	list = true, -- Show some common invisible characters
	listchars = {
		eol = "↵",
		extends = "↷",
		nbsp = "⦸",
		precedes = "↶",
		space = "␣",
		tab = ">-",
		trail = "·",
	},
	mouse = "a", -- allow the mouse to be used in neovim
	number = true, -- set numbered lines
	numberwidth = 2, -- set number column width to 2 {default 4}
	pumheight = 10, -- pop up menu height
	relativenumber = true, -- set relative numbered lines
	scrolloff = 8,
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	showmatch = true, -- highlight matched parenthesis
	showmode = true, -- show current mode
	showtabline = 2, -- always show tabs
	sidescrolloff = 8,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- do not create swapfile
	tabstop = 4, -- insert four spaces for a tab
	termguicolors = true, -- set term gui colors (most terminals support this)
	textwidth = 120, -- text width
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
	wildmenu = true,
	wrap = false, -- display lines as one long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Add flags to shorten vim messages
vim.opt.shortmess:append("c")

-- Set Python providers
-- Disable Python2 provider, only use Python3
vim.cmd([[
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
]])

-- Disable some unused built-in plugins
local disable_distribution_plugins = function()
	-- Do not load tohtml.vim
	vim.g.loaded_2html_plugin = 1
end
disable_distribution_plugins()
