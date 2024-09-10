from libqtile import widget

widgets = [
    widget.CurrentLayout(),
    widget.GroupBox(),
    widget.Prompt(),
    widget.WindowName(),
    widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
    widget.Systray(),
]
