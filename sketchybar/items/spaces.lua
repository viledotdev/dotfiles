local colors = require("colors")
local icon_map = require("icon_map")

local function get_apps_table(apps, delimiter)
	local result = {}
	local pattern = "([^" .. delimiter .. "]+)"
	apps:gsub(pattern, function(app)
		if result[app] == nil then
			result[app] = app
		end
	end)
	return result
end

local function space_selection(env)
	local wp_num = string.gsub(env.NAME, "item_", "")
	local workspace = tonumber(wp_num) - 1
	local selected = workspace == tonumber(env.CURRENT)
	local background_color = selected and colors.red or colors.bg2

	sbar.set(env.NAME, {
		icon = {
			highlight = selected,
		},
		label = { highlight = selected },
		background = { border_color = background_color },
	})
end

local function icon_display(env)
	-- For some reason env.NAME index starts at 2
	local wp_num = string.gsub(env.NAME, "item_", "")
	local workspace = tonumber(wp_num) - 1
	local icons = ""
	local get_apps = "aerospace list-windows --workspace " .. workspace .. " --format %{app-name}"

	sbar.exec(get_apps, function(result)
		local apps = get_apps_table(result, "\n")
		if next(apps) == nil then
			icons = "-"
		end
		for app in pairs(apps) do
			icons = icons .. icon_map.get_icon(app)
		end
		icons = string.gsub(icons, "::", ":     :")
		sbar.set(env.NAME, {
			icon = {
				string = icons,
			},
		})
	end)
end

for i = 1, 9, 1 do
	local space = sbar.add("item", {
		icon = {
			padding_left = 15,
			padding_right = 15,
			font = "sketchybar-app-font:Regular:16.0",
			color = colors.grey,
			highlight_color = colors.green,
		},
		padding_left = 5,
		background = { color = colors.bg1, border_color = colors.bg2 },
		padding_right = 5,
		label = {
			padding_right = 20,
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
			drawing = false,
		},
	})
	space:subscribe("workspace_changed", space_selection)
	space:subscribe("front_app_switched", icon_display)
	space:subscribe("app_space_changed", icon_display)
end

sbar.add("item", {
	padding_left = 10,
	padding_right = 8,
	icon = {
		string = "􀆊",
		font = {
			style = "Heavy",
			size = 16.0,
		},
		color = colors.green,
	},
	label = { drawing = false },
	associated_display = "active",
})
