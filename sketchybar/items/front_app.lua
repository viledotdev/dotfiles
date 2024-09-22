local colors = require("colors")
local icon_map = require("icon_map")

local front_app = sbar.add("item", {
	label = {
		font = {
			style = "Black",
			size = 12.0,
		},
	},
})

front_app:subscribe("front_app_switched", function(env)
	if env.INFO ~= nil then
		sbar.set(env.NAME, {
			position = "q",
			icon = {
				font = "sketchybar-app-font:Regular:16.0",
				color = colors.white,
				string = icon_map.get_icon(env.INFO),
				drawing = true,
				padding_left = 15,
				padding_right = 15,
			},
			padding_left = 5,
			background = { color = colors.black, border_color = colors.white },
			padding_right = 15,
			label = {
				color = colors.white,
				padding_right = 15,
				string = env.INFO,
			},
		})
	end
end)
