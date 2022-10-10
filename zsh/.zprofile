# it is recommended to set this env variable before setting any other
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

DRIVE_FOLDER="$HOME/drive/.local/share"

export PATH="$PATH:$HOME/scripts:$HOME/.local/bin"

export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"

# cause I don't let just anyone into my $HOME
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export CARGO_HOME="$XDG_DATA_HOME/cargo/"
export GNUPGHOME="$DRIVE_FOLDER/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # uncommenting this line will make the systemd service of locking PC before suspending it stop working

export DISABLE_AUTO_TITLE='true'  # tmuxp stuff

export QT_STYLE_OVERRIDE=kvantum  # apply GTK themes to Qt programs

export DISPLAY=:0 # for X11 apps to work

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep awesome || exec startx $HOME/.config/xinitrc
fi
