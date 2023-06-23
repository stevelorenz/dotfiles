--
-- options.lua
-- About: Zuo's Options Configuration for Neovim
--

local vim = vim

-- Less options, less problems...
local options = {
	backup = false, -- do not create backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	colorcolumn = { "80", "100" },
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorcolumn = true, -- highlight the current column
	cursorline = true, -- highlight the current line
	emoji = true,
	encoding = "utf-8",
	fileencoding = "utf-8", -- the encoding written to a file
	fileformats = { "unix" },
	foldmethod = "indent", -- use indent as the DEFAULT folding method. This method does not require treesitter
	-- foldmethod = "expr", -- use treesitter for folding
	-- foldexpr = "nvim_treesitter#foldexpr()", -- use treesitter for folding
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	laststatus = 3, -- Use global statusline
	lazyredraw = true, -- Faster scrolling
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
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
	wrap = false, -- display lines as one long line
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	wildmenu = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Add flags to shorten vim messages
vim.opt.shortmess:append("c")

-- Dot not form folds when opening the file
vim.cmd("set nofoldenable")

-- Show some invisible characters
vim.cmd([[
set list listchars=space:␣,tab:>-,eol:↵,trail:·,extends:↷,precedes:↶
]])

-- Set Python providers
-- Disable Python2 provider, only use Python3
vim.cmd([[
let g:loaded_python_provider = 0
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
]])
