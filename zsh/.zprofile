export PATH="$PATH:$HOME/scripts:$HOME/.local/bin"

export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"

# move folders out of HOME
export GNUPGHOME="$HOME/apps/.gnupg/"
export CARGO_HOME="$HOME/apps/cargo/"
export TMUXP_CONFIGDIR="$HOME/.config/tmuxp/"

export DISABLE_AUTO_TITLE='true'  # tmuxp stuff

export QT_STYLE_OVERRIDE=kvantum  # apply GTK themes to Qt programs

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep awesome || exec startx /home/rangelgbr/.config/xinitrc
fi
