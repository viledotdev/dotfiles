from keys import groups, keys
from layouts import layouts
from mouse import mouse
from screens import screens

widget_defaults = {
    "font": "RecMonoLinear Nerd Font Mono",
    "fontsize": 12,
    "padding": 3,
}
extension_defaults = widget_defaults.copy()

# Configuraciones adicionales

dgroups_key_binder = None
dgroups_app_rules = []  # Para configuraciones de grupo
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# Si usas Java apps, pon "LG3D" para arreglar problemas de Java
wmname = "LG3D"
