--
-- health.lua
-- About: Zuo's Health Check for Neovim
--
local M = {}

local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

function M.check()
    start("Zuo Neovim")

    for _, cmd in ipairs({"git", "curl"}) do
        local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
        local commands = type(cmd) == "string" and {cmd} or cmd
        ---@cast commands string[]
        local found = false

        for _, c in ipairs(commands) do
            if vim.fn.executable(c) == 1 then
                name = c
                found = true
            end
        end

        if found then
            ok(("`%s` is installed"):format(name))
        else
            warn(("`%s` is not installed"):format(name))
        end
    end
end

return M
