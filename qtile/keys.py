from const import MOD, TERMINAL
from libqtile.config import Group, Key
from libqtile.lazy import lazy

keys = [
    Key([MOD], "Return", lazy.spawn(TERMINAL), desc="Lanza la terminal"),
    Key([MOD], "d", lazy.window.kill(), desc="Cierra la ventana activa"),
    Key([MOD], "n", lazy.spawn("brave"), desc="Lanza el navegador Brave"),
    Key(
        [MOD],
        "m",
        lazy.layout.maximize(),
        desc="Maximiza/minimiza la ventana dentro del layout",
    ),
    Key(
        [MOD, "shift"],
        "v",
        lazy.group.setlayout("monadtall"),
        desc="Cambia al layout vertical",
    ),
    Key(
        [MOD, "shift"],
        "h",
        lazy.group.setlayout("monadwide"),
        desc="Cambia al layout horizontal",
    ),
    Key(
        [MOD, "shift"],
        "m",
        lazy.group.setlayout("max"),
        desc="Cambia al layout de pantalla completa",
    ),
    Key([MOD], "Up", lazy.layout.up(), desc="Cambia a la ventana de arriba"),
    Key([MOD], "Left", lazy.layout.left(), desc="Cambia a la ventana de la izquierda"),
    Key([MOD], "Down", lazy.layout.down(), desc="Cambia a la ventana de abajo"),
    Key([MOD], "Right", lazy.layout.right(), desc="Cambia a la ventana de la derecha"),
    Key([MOD], "Tab", lazy.next_layout(), desc="Cambia entre los layouts disponibles"),
    Key([MOD, "shift"], "r", lazy.restart(), desc="Reinicia Qtile"),
    Key([MOD, "shift"], "q", lazy.shutdown(), desc="Cierra Qtile"),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [MOD],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Ir al grupo {i.name}",
            ),
            Key(
                [MOD, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Mueve ventana al grupo {i.name}",
            ),
        ]
    )
