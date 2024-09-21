local colors = require("colors")
local icon_map = require("icon_map")

local whitelist = { ["Spotify"] = true, ["Music"] = true, ["Safari"] = true }

local media = sbar.add("item", {
	position = "e",
	updates = true,
})

media:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		media:set({
			icon = {
				font = "sketchybar-app-font:Regular:16.0",
				color = colors.magenta,
				string = icon_map.get_icon(env.INFO.app),
				drawing = true,
				padding_left = 15,
				padding_right = 10,
			},
			padding_left = 15,
			background = { color = colors.black, border_color = colors.magenta },
			padding_right = 5,
			drawing = (env.INFO.state == "playing") and true or false,
			label = {
				color = colors.magenta,
				padding_right = 15,
				string = env.INFO.artist .. ": " .. env.INFO.title,
			},
		})
	end
end)
