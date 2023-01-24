local wezterm = require("wezterm")
local catppuccin = require("colors/catppuccin").setup({})

return {
	font_hinting = "Full",
	font = wezterm.font("Cascadia Code", { weight = "Light", stretch = "Normal", italic = false }),
	font_size = 16.0,

	-- Use catppuccin theme
	colors = catppuccin,
	window_background_opacity = 0.99,
	default_cursor_style = "SteadyBlock",
	hide_tab_bar_if_only_one_tab = true,

	check_for_update = false,
}
