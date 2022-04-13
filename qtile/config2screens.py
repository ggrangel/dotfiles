import os
import subprocess
from pathlib import Path

from libqtile import bar, hook, qtile
from libqtile.command import lazy
from libqtile.config import Group, Key, Match, Screen
from libqtile.layout import MonadTall
from libqtile.layout.floating import Floating
from libqtile.widget.check_updates import CheckUpdates
from libqtile.widget.clock import Clock
from libqtile.widget.cpu import CPU
from libqtile.widget.image import Image
from libqtile.widget.memory import Memory
from libqtile.widget.pulse_volume import PulseVolume
from libqtile.widget.sensors import ThermalSensor
from libqtile.widget.sep import Sep
from libqtile.widget.spacer import Spacer

# from libqtile.widget.systray import Systray

# mod4 or mod = super key
mod = "mod4"
HOME = os.path.expanduser("~")
TERMINAL = "kitty"
BROWSER = "brave"
ICONS_PATH = Path("/home/rangelgbr/.config/qtile/icons")

COLORS = {
    "background": "#002b36",
    "foreground": "#fdf6e3",
    "blue1": "#268bd2",
    "blue2": "#5e81ac",
    "blue3": "#4c566a",
}


@hook.subscribe.startup_once
def start_once():
    subprocess.call([HOME + "/scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


# Assign apps to specific groups.
@hook.subscribe.client_new
def agroup(client):
    apps = {
        "brave-browser": 0,
        "telegram-desktop": 0,
        "whatsapp-nativefier-d40211": 2,
    }

    wm_class = client.window.get_wm_class()[0]
    group = apps.get(wm_class, None)
    if group:
        qtile.cmd_to_screen(group)


# Mouse callbacks functions.
def call_htop():
    qtile.cmd_spawn(TERMINAL + " -e htop -s PERCENT_MEM")


def call_pulsemixer():
    qtile.cmd_spawn(TERMINAL + " -e pulsemixer")


def call_gcalendar():
    qtile.cmd_spawn(BROWSER + " https://calendar.google.com")


def call_pacman_qu():
    # qtile.cmd_spawn(TERMINAL + " --hold -e pacman -Qu")
    # subprocess.call([HOME + "/scripts/updates.sh"])
    qtile.cmd_spawn("sh /home/rangelgbr/.config/qtile/scripts/updates.sh")


def init_widgets_list():
    separator = Sep(
        linewidth=1,
        padding=10,
        foreground=COLORS["foreground"],
        background=COLORS["background"],
    )
    widgets_list = [
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "calendar.png",
            margin_x=3,
            margin_y=3,
            mouse_callbacks={"Button1": call_gcalendar},
        ),
        Clock(
            foreground=COLORS["foreground"],
            background=COLORS["background"],
            fontsize=12,
            format="%a, %b %d - %H:%M",
            mouse_callbacks={"Button1": call_gcalendar},
        ),
        separator,
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "volume.png",
            margin_x=3,
            margin_y=3,
            mouse_callbacks={"Button3": call_pulsemixer},
        ),
        PulseVolume(
            background=COLORS["background"],
            foreground=COLORS["foreground"],
            fmt="{}",
            volume="pulsemixer",
            step=10,
            limit_max_volume=True,
            mouse_callbacks={"Button3": call_pulsemixer},
        ),
        separator,
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "hammer-and-wrench.png",
            margin_x=3,
            margin_y=3,
            mouse_callbacks={"Button1": call_pacman_qu},
        ),
        CheckUpdates(
            update_interval=1800,
            distro="Arch",
            display_format="{updates} Updates",
            foreground=COLORS["foreground"],
            background=COLORS["background"],
            mouse_callbacks={"Button1": call_pacman_qu},
            no_update_string="Up-to-date",
        ),
        separator,
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "brain.png",
            margin_x=0,
            margin_y=3,
            mouse_callbacks={"Button1": call_htop},
        ),
        Memory(
            foreground=COLORS["foreground"],
            background=COLORS["background"],
            format="{MemPercent}%",
            mouse_callbacks={"Button1": call_htop},
        ),
        separator,
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "desktop-computer.png",
            margin_x=3,
            margin_y=3,
        ),
        CPU(
            format="{load_percent}% ",
            font="UbuntuMono Nerd Font",
            fontsize=14,
            foreground=COLORS["foreground"],
            background=COLORS["background"],
            update_interval=3,
        ),
        separator,
        Image(
            background=COLORS["background"],
            foreground=COLORS["foreground"],
            filename=ICONS_PATH / "fire.png",
            margin_x=3,
            margin_y=3,
        ),
        ThermalSensor(
            background=COLORS["background"],
        ),
        Spacer(
            background=COLORS["background"],
        ),
        # Systray(background=COLORS["background"], foreground=COLORS["foreground"]),
    ]
    return widgets_list


layout_theme = {
    "margin": 0,
    "border_width": 3,
    "border_focus": COLORS["blue2"],
    "border_normal": COLORS["blue3"],
}

layouts = [
    MonadTall(**layout_theme),
]

groups = [Group(i) for i in "123"]

screens = [
    Screen(),
    Screen(bottom=bar.Bar(widgets=init_widgets_list(), size=24, opacity=0.8)),
]

# For other keybindings, check sxhkd
keys = [
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "space", lazy.next_layout()),
    # CHANGE APPLICATION FOCUS
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    # CHANGE SCREEN FOCUS
    # Key([mod], "1", lazy.to_screen(1)),
    # Key([mod], "2", lazy.to_screen(0)),
    # Key([mod], "3", lazy.to_screen(2)),
    # RESIZE UP, DOWN, LEFT, RIGHT
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    # Flip layout for monadtall/monadwide.
    Key([mod, "shift"], "f", lazy.layout.flip()),
    # Move windows over layout.
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod], "9", lazy.to_screen(0)),
    Key([mod], "0", lazy.to_screen(1)),
    Key([mod, "control"], "9", lazy.window.toscreen(0)),
    Key([mod, "control"], "0", lazy.window.toscreen(1)),
    Key([mod, "shift"], "9", lazy.window.toscreen(0), lazy.to_screen(0)),
    Key([mod, "shift"], "0", lazy.window.toscreen(1), lazy.to_screen(1)),
]

floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        # Match(wm_class="Insync"),  # gitk
        Match(wm_class="pinentry-gtk-2"),  # passphrase unlock
    ],
    fullscreen_border_width=0,
    border_width=0,
)

#     Drag(
#         [mod],
#         "Button1",
#         lazy.window.set_position_floating(),
#         start=lazy.window.get_position(),
#     ),
#     Drag(
#         [mod],
#         "Button3",
#         lazy.window.set_size_floating(),
#         start=lazy.window.get_size(),
#     ),
# ]

# lazy.next_screen()

# The cursor follows the focus as directed by the keyboard,
# warping to the center of the focused window.
cursor_warp = True

focus_on_window_activation = "focus"
