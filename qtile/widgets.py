from libqtile import widget
from theme import colors

# Inspired by Antonio Sarosi's config


def base(fg="text", bg="dark", font="RecMonoLinear Nerd Font Mono"):
    return {
        "foreground": colors[fg],
        "background": colors[bg],
        "font": font,
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="dark", fontsize=20, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=6)


def powerline(fg="light", bg="dark"):
    return widget.TextBox(**base(fg, bg))


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="light"),
            fontsize=28,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors["active"],
            inactive=colors["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["grey"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            disable_drag=True,
        ),
        separator(),
        widget.WindowName(**base(fg="focus"), fontsize=14, padding=8),
        separator(),
    ]


def baticon(bat=0, fontsize=22):
    return widget.Battery(
        **base(bg="color5"),
        battery="/sys/class/power_supply/BAT" + str(bat),
        format="{char}",
        fontsize=fontsize,
        update_interval=10,
        charge_char="󰂄",
        discharge_char="󰂃",
        full_char="󰁹",
        unknown_char="󰂑",
        empty_char="󰂎",
        not_charging_char="󱈑",
        low_percetage=0.25,
        show_short_text=False,
    )


widgets = [
    *workspaces(),
    separator(),
    widget.Pomodoro(
        **base(bg="dark"),
        color_inactive="#952021",  # Color cuando está inactivo
        color_active="#F9E859",  # Color cuando está en modo trabajo
        color_break="#3F8940",  # Color cuando está en modo descanso
        prefix_inactive=" Start",  # Texto cuando está inactivo
        prefix_active=" ",  # Texto cuando está en trabajo
        prefix_paused=" Paused",  # Texto cuando está en trabajo
        prefix_break=" ",  # Texto cuando está en descanso
        fontsize=26,
        length_pomodori=25,  # Duración del periodo de trabajo en minutos
        length_short_break=5,  # Duración del descanso corto en minutos
        length_long_break=30,  # Duración del descanso largo en minutos
        num_pomodori=4,  # Número de pomodoros antes de un descanso largo
    ),
    separator(),
    powerline("color4", "dark"),
    icon(bg="color4", text=" "),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors["color4"],
        colour_have_updates=colors["text"],
        colour_no_updates=colors["text"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
        custom_command="checkupdates",
    ),
    powerline("color4", "color3"),
    icon(bg="color3", text=" "),  # Icon: nf-fa-feed
    widget.Net(**base(bg="color3"), interface="wlan0"),
    powerline("color3", "color2"),
    widget.CurrentLayoutIcon(**base(bg="color2"), scale=0.65),
    widget.CurrentLayout(**base(bg="color2"), padding=5),
    powerline("color2", "color1"),
    icon(bg="color1", text="󰃰 "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color1"), format="%d/%m/%Y - %H:%M "),
    powerline("color1", "color5"),
    baticon(0),
    widget.Battery(
        **base(bg="color5"),
        battery="/sys/class/power_supply/BAT0",
        format="i {percent:2.0%} {hour:d}:{min:02d}",
        update_interval=10,
    ),
    baticon(1),
    widget.Battery(
        **base(bg="color5"),
        battery="/sys/class/power_supply/BAT1",
        format="e {percent:2.0%} {hour:d}:{min:02d}",
        update_interval=10,
        show_short_text=False,
        padding=5,
    ),
    powerline("color5", "dark"),
    widget.Systray(background=colors["dark"], padding=5),
    powerline("dark", "dark"),
]
