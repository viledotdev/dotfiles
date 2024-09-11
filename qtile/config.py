import os
import subprocess

from groups import groups
from keys import keys
from layouts import layouts
from libqtile import hook
from mouse import mouse
from screens import screens


@hook.subscribe.startup_once
def autostart():
    script_path = os.path.expanduser("~/dotfiles/qtile/starter.sh")
    wallpaper_path = os.path.expanduser("~/dotfiles/assets/wallpaper.jpg")
    subprocess.run(["sh", script_path], check=True)
    subprocess.run(
        ["feh", "--bg-scale", wallpaper_path],
        check=True,
    )


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
