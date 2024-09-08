-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "HaX0R_BLUE"
config.font = wezterm.font("Menlo")
config.font_size = 22.0
config.line_height = 1.3

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Pane config
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "t", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "n", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "s", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
}
-- and finally, return the configuration to wezterm
return config
