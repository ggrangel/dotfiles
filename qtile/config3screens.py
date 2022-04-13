import os
import subprocess
from pathlib import Path

from libqtile import bar, hook, qtile
from libqtile.command import lazy
from libqtile.config import Drag, Group, Key, Match, Screen
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


# Assign apps to specific screen.
@hook.subscribe.client_new
def agroup(client):
    apps = {
        "brave-browser": 0,
        "discord": 2,
        "Insync": 2,
        "org.gnome.clocks": 2,
        "slack": 2,
        "telegram-desktop": 2,
        "whatsapp-nativefier-d40211": 2,
    }

    wm_class = client.window.get_wm_class()[0]
    group = apps.get(wm_class, None)
    if group:
        qtile.cmd_to_screen(group)


# @hook.subscribe.restart
# def regroup_restart():
#     apps = {
#         "brave-browser": 2,
#         "discord": 1,
#         "org.gnome.clocks": 1,
#         "telegram-desktop": 1,
#         "whatsapp-nativefier-d40211": 1,
#     }


# Mouse callbacks functions.
def call_htop():
    qtile.cmd_spawn(TERMINAL + " -e htop -s PERCENT_MEM")


def call_pulsemixer():
    qtile.cmd_spawn(TERMINAL + " -e pulsemixer")


def call_gcalendar():
    qtile.cmd_spawn(BROWSER + " https://calendar.google.com")


def call_pacman_qu():
    qtile.cmd_spawn("sh /home/rangelgbr/.config/qtile/scripts/updates.sh")


def call_alarm():
    qtile.cmd_spawn("gnome-clocks")


# widgets
def separator():
    return Sep(
        linewidth=1,
        padding=10,
        foreground=COLORS["foreground"],
        background=COLORS["background"],
    )


def thermal_sensor():
    return (
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
    )


def cpu():
    return (
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
    )


def memory():
    return (
        Image(
            background=COLORS["background"],
            foreground=COLORS["foreground"],
            filename=ICONS_PATH / "brain.png",
            margin_x=3,
            margin_y=3,
            mouse_callbacks={"Button1": call_htop},
        ),
        Memory(
            background=COLORS["background"],
            foreground=COLORS["foreground"],
            format="{MemPercent}%",
            mouse_callbacks={"Button1": call_htop},
        ),
    )


def check_updates():
    return (
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
    )


def volume():
    return (
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
            mouse_callbacks={"Button3": call_pulsemixer},
        ),
    )


def calendar():
    return (
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
            format="%a, %b %d - %H:%M:%S",
            # format="%a, %b %d",
            mouse_callbacks={"Button1": call_gcalendar},
        ),
    )


def clock():
    return (
        Image(
            background=COLORS["background"],
            filename=ICONS_PATH / "clock.png",
            margin_x=3,
            margin_y=3,
            mouse_callbacks={"Button1": call_alarm},
        ),
        Clock(
            foreground=COLORS["foreground"],
            background=COLORS["background"],
            fontsize=12,
            format="%H:%M:%S",
            mouse_callbacks={"Button1": call_alarm},
        ),
    )


widgets_list = [
    Spacer(
        background=COLORS["background"],
    ),
    *thermal_sensor(),
    separator(),
    *cpu(),
    separator(),
    *memory(),
    separator(),
    *check_updates(),
    separator(),
    *volume(),
    separator(),
    *calendar(),
    separator(),
    *clock(),
]

widgets_list_reverse = [
    # *clock(),
    # separator(),
    *calendar(),
    separator(),
    *volume(),
    separator(),
    *check_updates(),
    separator(),
    *memory(),
    separator(),
    *cpu(),
    separator(),
    *thermal_sensor(),
    Spacer(background=COLORS["background"]),
]


layout_theme = {
    "margin": 0,
    "border_width": 3,
    "border_focus": COLORS["blue2"],
    "border_normal": COLORS["blue3"],
    "single_border_width": 0,
    "single_margin": 0,
}

monad_tall_left = MonadTall(**dict(layout_theme, **{"ratio": 0.7, "align": 1}))

monad_tall_centre = MonadTall(**layout_theme)

monad_tall_right = MonadTall(**dict(layout_theme, **{"ratio": 0.618}))

# layout with master split on left position
# tile = Tile(
#     **dict(
#         layout_theme,
#         **{
#             "expand": False,
#             "master_match": Match(wm_class="brave-browser"),
#             "add_on_top": False,
#             "shift_windows": True,
#         }
#     )
# )

# layout with master split on right position
# slice = Slice(
#     match=Match(wm_class="brave-browser"),
#     side="right",
#     width=int(1920 * 0.618),
#     fallback=VerticalTile(**layout_theme),
# )

layouts_left_screen = [monad_tall_right]

layouts_middle_screen = [monad_tall_left]

layouts_right_screen = [monad_tall_right]

groups = [
    Group("2", layouts=layouts_left_screen),
    Group("1", layouts=layouts_middle_screen),
    Group("3", layouts=layouts_right_screen),
]

screens = [
    Screen(),
    Screen(),
    Screen(bottom=bar.Bar(widgets=widgets_list_reverse, size=24, opacity=0.8)),
]

# For other keybindings, check sxhkd
keys = [
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
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
    Key([mod], "8", lazy.to_screen(0)),
    Key([mod], "9", lazy.to_screen(1)),
    Key([mod], "0", lazy.to_screen(2)),
    Key([mod, "control"], "8", lazy.window.toscreen(0)),
    Key([mod, "control"], "9", lazy.window.toscreen(1)),
    Key([mod, "control"], "0", lazy.window.toscreen(2)),
    Key([mod, "shift"], "8", lazy.window.toscreen(0), lazy.to_screen(0)),
    Key([mod, "shift"], "9", lazy.window.toscreen(1), lazy.to_screen(1)),
    Key([mod, "shift"], "0", lazy.window.toscreen(2), lazy.to_screen(2)),
]

Drag(
    [mod],
    "Button1",
    lazy.window.set_position_floating(),
    start=lazy.window.get_position(),
),
Drag(
    [mod],
    "Button3",
    lazy.window.set_size_floating(),
    start=lazy.window.get_size(),
),

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

# lazy.next_screen()

# The cursor follows the focus as directed by the keyboard,
# warping to the center of the focused window.
cursor_warp = True

focus_on_window_activation = "focus"

widget_defaults = dict(font="Hack Nerd Font", fontsize=12, padding=3)
