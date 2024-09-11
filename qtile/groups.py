from const import MOD
from keys import keys
from libqtile.config import Group, Key
from libqtile.lazy import lazy

groups = [
    Group(i)
    for i in [
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        "   ",
        " 󰅟  ",
    ]
]

for i, group in enumerate(groups):
    _KEY = str(i + 1)
    keys.extend(
        [
            Key([MOD], _KEY, lazy.group[group.name].toscreen()),
            Key([MOD, "shift"], _KEY, lazy.window.togroup(group.name)),
        ]
    )
