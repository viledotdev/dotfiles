local colors = require("colors")
local icon_map = require("icon_map")

local whitelist = { ["Spotify"] = true, ["Music"] = true, ["Safari"] = true, ["YouTube"] = true, ["Podcasts"] = true }

local media = sbar.add("item", {
	position = "e",
	updates = true,
})
function media_change(env)
	local color = (env.INFO.state == "playing") and colors.magenta or colors.grey
	local playing = (env.INFO.state == "playing") and true or false
	if whitelist[env.INFO.app] then
		media:set({
			icon = {
				font = "sketchybar-app-font:Regular:16.0",
				color = color,
				string = icon_map.get_icon(env.INFO.app),
				drawing = true,
				padding_left = 15,
				padding_right = 10,
			},
			padding_left = 15,
			background = { color = colors.black, border_color = color },
			padding_right = 5,
			scroll_texts = playing,
			drawing = true,
			label = {
				color = color,
				scroll_duration = 200,
				max_chars = 20,
				padding_right = 15,
				string = env.INFO.artist .. ": " .. env.INFO.title,
			},
		})
	end
end

media:subscribe("media_change", media_change)
