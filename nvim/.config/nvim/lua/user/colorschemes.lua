--
-- colorscheme.lua
--
local ok, _ = pcall(require, "catppuccin")

if ok then
    -- I like catppuccin theme and use it for terminal, Gnome, Neovim and so on...
    vim.cmd.colorscheme("catppuccin")

    -- Catppuccin
    require("catppuccin").setup({
        lazy = true,
        flavor = "mocha",
        -- Pre-compile the configuration and store it in nvim's cache
        compile = {
            enabled = true,
            path = vim.fn.stdpath("cache") .. "/catppuccin",
            suffix = "_compiled"
        },

        integration = {
            aerial = true,
            alpha = true,
            cmp = true,
            dashboard = true,
            flash = true,
            gitsigns = true,
            headlines = true,
            illuminate = true,
            indent_blankline = {enabled = true},
            leap = true,
            lsp_trouble = true,
            mason = true,
            markdown = true,
            mini = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = {"undercurl"},
                    hints = {"undercurl"},
                    warnings = {"undercurl"},
                    information = {"undercurl"}
                }
            },
            navic = {enabled = true, custom_bg = "lualine"},
            neotest = true,
            neotree = true,
            noice = true,
            notify = true,
            semantic_tokens = true,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            which_key = true
        },
        styles = {}
    })
else
    -- Fall back to built-in slate
    vim.cmd.colorscheme("slate")
end
