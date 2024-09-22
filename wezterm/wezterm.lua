-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices
config = {

	window_background_opacity = 1,
	enable_tab_bar = false,
	inactive_pane_hsb = {
		saturation = 0.75,
		brightness = 0.45,
	},
	automatically_reload_config = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	background = {
		{
			source = {
				Color = "#02051F",
			},
			width = "100%",
			height = "100%",
			opacity = 0.75,
		},
	},
	-- For example, changing the color scheme:
	color_scheme = "Tokio Night",
	font = wezterm.font("RecMonoLinear Nerd Font Mono"),
	font_size = 16.0,
	line_height = 1.25,

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		-- Pane config
		{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "t", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "n", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "s", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	},
}
-- and finally, return the configuration to wezterm
return config
