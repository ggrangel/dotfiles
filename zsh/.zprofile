export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_CACHE_HOME="$HOME/.cache/"
export XDG_DATA_HOME="$HOME/.local/share/"

export PATH="$PATH:$HOME/scripts:$HOME/.local/bin"

export TERMINAL="kitty"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="brave"

# moving uninvited out of my home
export TMUXP_CONFIGDIR="$HOME/.config/tmuxp/"
export GNUPGHOME="$HOME/apps/gnupg/"
export CARGO_HOME="$HOME/apps/cargo/"
export GOPATH="$HOME/apps/go"
export GTK2_RC_FILES="$HOME/apps/gtk-2.0/gtkrc"
export NPM_CONFIG_USERCONFIG="$HOME/apps/npm/npmrc"
export NVM_DIR="$HOME/apps/nvm"
export PYENV_ROOT="$HOME/apps/pyenv" 
export BUNDLE_USER_CONFIG="$HOME/apps/bundle"
export BUNDLE_USER_CACHE="$HOME/apps/bundle"
export BUNDLE_USER_PLUGIN="$HOME/apps/bundle"
export XAUTHORITY="$HOME/apps/Xauthority"
export PASSWORD_STORE_DIR="$HOME/apps/pass" 

export DISABLE_AUTO_TITLE='true'  # tmuxp stuff

export QT_STYLE_OVERRIDE=kvantum  # apply GTK themes to Qt programs

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep awesome || exec startx /home/rangelgbr/.config/xinitrc
fi
