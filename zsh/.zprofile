# [[ -f ~/.config/zsh/.zshrc ]] && . ~/.config/zsh/.zshrc

export PATH="$PATH:$HOME/scripts:$PYENV_ROOT/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.rvm/bin"

export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"

export GNUPGHOME="$HOME/apps/.gnupg/"
export CARGO_HOME="$HOME/apps/cargo/"
# export HISTCONTROL=ignoreboth # removes duplicates from zsh history.
export _ZO_ECHO=1 # z will print the matched directory before navigating to it.

export DISABLE_AUTO_TITLE='true'  # tmuxf stuff
export TMUXP_CONFIGDIR="$HOME/.config/tmuxp/"

export QT_STYLE_OVERRIDE=kvantum  # apply GTK themes to Qt programs

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep awesome || exec startx /home/rangelgbr/.config/xinitrc
# elif [[ "$(tty)" = "/dev/tty2" ]]; then
#     pgrep qtile || startx /home/rangelgbr/.config/xinit/xinitrc-qtile
fi
