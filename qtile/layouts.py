from libqtile import layout
from libqtile.config import Match
from theme import colors

layout_conf = {"border_focus": colors["focus"], "border_width": 1, "margin": 4}

layouts = [
    layout.Max(),
    layout.MonadTall(**layout_conf),
    layout.MonadWide(**layout_conf),
]


floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus=colors["color4"],
)
