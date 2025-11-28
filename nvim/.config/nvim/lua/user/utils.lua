--
-- utils.lua
-- About: Utility functions
--
-- Nice! A function mapper
local M = {}

function M.executable(name)
	if vim.fn.executable(name) > 0 then
		return true
	end

	return false
end

--- Check if a feature exists in current Neovim
--- @param feat (string): feature name, e.g., `unix`
--- @return: boolean
M.has = function(feat)
	if vim.fn.has(feat) == 1 then
		return true
	end

	return false
end

return M
