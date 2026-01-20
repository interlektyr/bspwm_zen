-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 125
config.initial_rows = 45
config.window_padding = {
	left = 20,
	right = 20,
	top = 15,
	bottom = 15,
}

-- or, changing the font size and color scheme.
config.font = wezterm.font("DepartureMono Nerd Font")
config.font_size = 11

config.font_rules = {

	{
		intensity = "Bold",
		font = wezterm.font("DepartureMono Nerd Font", { weight = "Regular" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("DepartureMono Nerd Font", { weight = "Regular" }),
	},
}
-- config.color_scheme = "AdventureTime"

config.enable_tab_bar = false
config.detect_password_input = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"
config.front_end = "OpenGL"

-- my coolnight colorscheme:
config.colors = {
	foreground = "#f8f9e8",
	background = "#1e2528",
	cursor_bg = "#f5d098",
	cursor_border = "#f5d098",
	cursor_fg = "#171c1f",
	selection_bg = "#374145",
	selection_fg = "#f8f9e8",
	ansi = { "#1e2528", "#f57f82", "#cbe3b3", "#f5d098", "#b2caed", "#f3c0e5", "#b3e3ca", "#f8f9e8" },
	brights = { "#262f33", "#f57f82", "#cbe3b3", "#f5d098", "#b2caed", "#f3c0e5", "#b3e3ca", "#96b4aa" },
}

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 600

-- Finally, return the configuration to wezterm:
return config
