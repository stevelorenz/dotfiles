local wezterm = require("wezterm")
local catppuccin = require("colors/catppuccin").setup({})

return {
	-- Font
	font = wezterm.font("Cascadia Code", { weight = "Light", stretch = "Normal", italic = false }),
	font_size = 16.0,

	-- Use catppuccin theme
	colors = catppuccin,
	window_background_opacity = 0.99,
	default_cursor_style = "SteadyBlock",
	hide_tab_bar_if_only_one_tab = false,

	-- Misc
	window_padding = {
		left = 10,
		right = 10,
		top = 2,
		bottom = 2,
	},
	check_for_updates = false
}
