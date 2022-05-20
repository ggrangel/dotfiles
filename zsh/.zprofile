# it is recommended to set this env variable before setting any other
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH="$PATH:$HOME/scripts:$HOME/.local/bin"

export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"

# cause I don't let just anyone into my $HOME
export TMUXP_CONFIGDIR="$HOME/.config/tmuxp/"
export GNUPGHOME="$HOME/apps/gnupg/"
export CARGO_HOME="$HOME/apps/cargo/"
export GOPATH="$HOME/apps/go"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc"
export NVM_DIR="$HOME/apps/nvm"
export PYENV_ROOT="$HOME/apps/pyenv" 
export XAUTHORITY="$HOME/apps/Xauthori"
export PASSWORD_STORE_DIR="$HOME/apps/pass" 
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

export DISABLE_AUTO_TITLE='true'  # tmuxp stuff

export QT_STYLE_OVERRIDE=kvantum  # apply GTK themes to Qt programs

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep awesome || exec startx /home/rangelgbr/.config/xinitrc
fi
