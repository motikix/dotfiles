local wezterm = require("wezterm")

return {
	term = "wezterm",
	font = wezterm.font("monospace"),
	font_size = 14,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
}
