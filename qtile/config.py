from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"  # Super key (Windows key)
terminal = (
    guess_terminal()
)  # Puedes cambiar esto a tu terminal favorita, por ejemplo "alacritty" o "wezterm"

keys = [
    Key([mod], "Return", lazy.spawn("wezterm"), desc="Lanza la terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Cierra la ventana activa"),
    Key([mod], "n", lazy.spawn("brave"), desc="Lanza el navegador Brave"),
    Key([mod], "Tab", lazy.next_layout(), desc="Cambia entre los layouts disponibles"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Reinicia Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Cierra Qtile"),
]

# Define los grupos de trabajo
groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Ir al grupo {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Mueve ventana al grupo {i.name}",
            ),
        ]
    )

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Systray(),
            ],
            24,
        ),
    ),
]

# Configuraciones adicionales
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # Para configuraciones de grupo
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# Si usas Java apps, pon "LG3D" para arreglar problemas de Java
wmname = "LG3D"
