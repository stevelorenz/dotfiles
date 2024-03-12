--
-- plugins_config.lua
-- About: Configuration for all installed plugins. Configuration is separated from plugin management in ./plugins.lua
--

---------------
--  lualine  --
---------------
require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
})

------------------
--  Bufferline  --
------------------
vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		separator_style = "padded_slant",
	},
})

-----------------
--  Telescope  --
-----------------
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
require("telescope").load_extension("fzf")

-- Load telescope-file-browser
require("telescope").load_extension("file_browser")

----------------
--  undotree  --
----------------
vim.g.undotree_SetFocusWhenToggle = 1

------------------------
--  indent_blankline  --
------------------------
require("ibl").setup({})

------------------
--  treesitter  --
------------------
require("nvim-treesitter.configs").setup({
	-- Install only modules for the languages I use frequently
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"css",
		"gitignore",
		"go",
		"haskell",
		"html",
		"javascript",
		"json",
		"latex",
		"lua",
		"markdown",
		"markdown_inline",
		"perl",
		"python",
		"regex",
		"ruby",
		"rust",
		"vim",
		"vimdoc",
		"yaml",
	},
	auto_install = true,
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},
	additional_vim_regex_highlighting = false,
	-- Use built-in "smart select" feature. It's an alternative for the vim-expand-region plugin
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_decremental = "<S-TAB>",
			node_incremental = "<TAB>",
			scope_incremental = false,
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = false,
		},
	},
})

require("treesitter-context").setup({
	enable = true,
})

----------------
--  gitsigns  --
----------------
require("gitsigns").setup({})

-----------------
--  which-key  --
-----------------
require("which-key").setup({
	plugins = { spelling = true },
})

----------------------
--  nvim-autopairs  --
----------------------
require("nvim-autopairs").setup({})

-----------------
--  nvim-tree  --
-----------------
require("nvim-tree").setup({})

----------------
--  nvim-bqf  --
----------------
require("bqf").setup({})

-------------
--  Mason  --
-------------
-- Following order is required: mason -> mason-lspconfig -> lspconfig
require("mason").setup({
	ensure_installed = {
		"stylua",
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {},
})

-------------
--  Neodev --
-------------
require("neodev").setup({})

----------------
--  nvim-lsp  --
----------------
-- Setup Neovim's built-in LSP client
-- Configs are copied and adapted from lspconfig's README (May be outdated...)

local lspconfig = require("lspconfig")

-- LSP servers that use the default setup, namely without any customized configs
local servers_default = {
	"bashls",
	"cmake",
	"erlangls",
	"gopls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"solargraph",
	"sqlls",
	"vimls",
	"yamlls",
}
for _, lsp in pairs(servers_default) do
	lspconfig[lsp].setup({})
end

-- LSP servers that use customized setup
-- clangd: DO NOT auto insert (often wrong) include headers...
lspconfig.clangd.setup({
	cmd = { "clangd", "--header-insertion=never" },
})

-- Global mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

----------------------
--  fidget.nvim  -  --
----------------------
require("fidget").setup({})

---------------------
--  lsp_signature  --
---------------------
require("lsp_signature").setup({
	bind = true, -- This is mandatory, otherwise border config won't get registered.
	handler_opts = {
		border = "rounded",
	},
})

--------------
--  neogen  --
--------------
require("neogen").setup({
	enabled = true,
	languages = {
		python = {
			template = {
				-- "google_docstrings"
				-- "numpydoc"
				-- "reST"
				annotation_convention = "reST",
			},
		},
	},
})

----------------
--  nvim-cmp  --
----------------
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
-- copy/paste from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp = require("cmp")
local cmp_defaults = require("cmp.config.default")()
cmp.setup({
	completion = {
		-- Uncomment the next line to disable autocompletion (Trigger completion manually)
		-- autocomplete = false,
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		-- NOTE: Unfortunately, nvim-cmp now requires using a snippet engine even if you don't want to use one... So I
		-- use the vsnip which is provided by the same author of the nvim-cmp plugin
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-CR>"] = function(fallback)
			cmp.abort()
			fallback()
		end,
	}),
	sources = {
		{ name = "buffer", keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 3 },
		{ name = "path", keyword_length = 3 },
		{ name = "vsnip", keyword_length = 3 },
	},
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	sorting = cmp_defaults.sorting,
})

---------------
--  trouble  --
---------------
require("trouble").setup({})

----------------
--  lspsaga  --
----------------
require("lspsaga").setup({
	-- code action prompt does not work properly for e.g. bash sources...
	code_action_lightbulb = {
		enable = false,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
})

------------------
--  marks.nvim  --
------------------
require("marks").setup({})

----------------------
--  nvim-lastplace  --
----------------------
require("nvim-lastplace").setup({})

----------------
--  nvim-ufo  --
----------------
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

--------------------------
--  todo-comments.nvim  --
--------------------------
require("todo-comments").setup({})

----------------------
--  vim-illuminate  --
----------------------
require("illuminate").configure({
	delay = 200,
	large_file_cutoff = 2000,
	large_file_overrides = {
		providers = { "lsp" },
	},
})

-----------------
--  colorizer  --
-----------------
require("colorizer").setup({})

------------------
--  noice.nvim  --
------------------
-- require("noice").setup({
-- 	lsp = {
-- 		signature = {
-- 			enabled = false,
-- 		},
-- 		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
-- 		override = {
-- 			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 			["vim.lsp.util.stylize_markdown"] = true,
-- 			["cmp.entry.get_documentation"] = true,
-- 		},
-- 	},
-- 	-- Define preset for easier configuration
-- 	presets = {
-- 		bottom_search = true, -- use a classic bottom cmdline for search
-- 		command_palette = true, -- position the cmdline and popupmenu together
-- 		long_message_to_split = true, -- long messages will be sent to a split
-- 		inc_rename = false, -- enables an input dialog for inc-rename.nvim
-- 		lsp_doc_border = false, -- add a border to hover docs and signature help
-- 	},
-- })

-----------------------
--  mini.animate  -  --
-----------------------
require("mini.animate").setup({})

-----------------------
--  mini.trailspace  --
-----------------------
require("mini.trailspace").setup()
