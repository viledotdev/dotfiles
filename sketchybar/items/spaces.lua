local colors = require("colors")
local icon_map = require("icon_map")

local n_space_icon = { "􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋" }

sbar.add("item", {
	padding_right = 10,
	icon = {
		font = {
			size = 22.0,
		},
	},
	label = { drawing = false },
})

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
	local workspace = tonumber(wp_num)
	local current = tonumber(env.CURRENT)
	local selected = workspace == current
	local border = selected and colors.white or colors.bg2
	local hidden = tonumber(env.CURRENT) > 6
	local space_icon_color = hidden and colors.yellow or colors.blue

	sbar.set("item_0", {
		icon = {
			string = n_space_icon[current],
			color = space_icon_color,
		},
		label = { highlight = selected },
		background = { border_color = border },
	})

	sbar.set(env.NAME, {
		icon = {
			highlight = selected,
		},
		label = { highlight = selected },
		background = { border_color = border },
	})
end

local function icon_display(env)
	local wp_num = string.gsub(env.NAME, "item_", "")
	local workspace = tonumber(wp_num)
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
		icons = string.gsub(icons, "::", ":  :")
		sbar.set(env.NAME, {
			icon = {
				string = icons,
			},
		})
	end)
end

for i = 1, 6, 1 do
	local space = sbar.add("item", {
		icon = {
			padding_left = 15,
			padding_right = 15,
			font = "sketchybar-app-font:Regular:16.0",
			color = colors.grey,
			highlight_color = colors.white,
		},
		padding_left = 5,
		background = { color = colors.bg1, border_color = colors.bg2 },
		padding_right = 5,
		label = {
			drawing = false,
		},
	})
	space:subscribe("workspace_changed", space_selection)
	space:subscribe("front_app_switched", icon_display)
	space:subscribe("app_space_changed", icon_display)
end
