# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# diable Ctrl+s (freezes the terminal)
stty -ixon

setopt autocd autopushd

# creating env variable to be easier to grep
export ZSH_HISTORY=$HOME/.cache/zsh_history

HISTFILE=$ZSH_HISTORY
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS  # do not write duplicates to history
setopt HIST_FIND_NO_DUPS  # when searching, do not show duplicates (apparently, it does not work)
# setopt SHARE_HISTORY

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# vi mode
bindkey -v
export KEYTIMOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"

pcName=$(cat /etc/hostname)
if [[ $pcName == "work" ]]; then
    source /home/rangelgbr/.config/zsh/auth.cfg
    http_proxy=$PROXY_SETTINGS
    https_proxy=$http_proxy
    no_proxy=$NO_PROXY
fi

export PYENV_ROOT="$HOME/.pyenv"

export PATH="$PATH:$HOME/scripts:$PYENV_ROOT/bin:$HOME/.cargo/bin:$HOME/.local/bin"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Starts ssh-agent to avoid having to enter ssh passphrase every time
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    # Saves passprhrase for 8h
    ssh-agent -t 8h > "$XDG_RUNTIME_DIR/ssh-agent.env"
    # lxsession that is run at startup starts an ssh-agent that is unusable because
    # it does not set the SSH environment variables
    # killall ssh-agent  
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# export PYTHONPATH="${PYTHONPATH}:/home/rangelgbr/projects/ogum" 

# load zhs-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

