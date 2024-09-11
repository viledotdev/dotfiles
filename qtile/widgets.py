from libqtile import widget
from theme import colors


def base(fg="text", bg="dark"):
    return {"foreground": colors[fg], "background": colors[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg="text", bg="dark", fontsize=22, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=6)


def powerline(fg="light", bg="dark"):
    return widget.TextBox(**base(fg, bg))


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="light"),
            font="RecMonoLinear Nerd Font Mono",
            fontsize=22,
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
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg="focus"), fontsize=14, padding=8),
        separator(),
    ]


widgets = [
    *workspaces(),
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
    powerline("color3", "color4"),
    icon(bg="color3", text=" "),  # Icon: nf-fa-feed
    widget.Net(**base(bg="color3"), interface="wlp2s0"),
    powerline("color2", "color3"),
    widget.CurrentLayoutIcon(**base(bg="color2"), scale=0.65),
    widget.CurrentLayout(**base(bg="color2"), padding=5),
    powerline("color1", "color2"),
    icon(bg="color1", text="󰃰 "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color1"), format="%d/%m/%Y - %H:%M "),
    powerline("dark", "color1"),
    widget.Systray(background=colors["dark"], padding=5),
]
