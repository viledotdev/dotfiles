local icons = require("icons")

-- Añadir el ítem de red
local network = sbar.add("item", {
	position = "right",
	icon = {
		font = {
			style = "Regular",
			size = 19.0,
		},
	},
	label = { drawing = false },
	update_freq = 30, -- Actualiza cada 30 segundos
})

-- Función para actualizar el estado de la red
local function network_update()
	sbar.exec("ifconfig en0", function(wifi_status)
		sbar.exec("ifconfig en1", function(ethernet_status)
			local icon = "!"

			if string.find(wifi_status, "status: active") then
				icon = icons.network.wifi
			elseif string.find(ethernet_status, "status: active") then
				icon = icons.network.ethernet
			else
				icon = icons.network.disconnected
			end

			network:set({ icon = icon })
		end)
	end)
end

-- Suscripción a eventos y actualizaciones periódicas
network:subscribe({ "routine", "wifi_change", "system_woke" }, network_update)
