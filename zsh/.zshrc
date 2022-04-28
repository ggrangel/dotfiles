# Change prompt
fpath=($HOME/.config/zsh/prompt $fpath)
source $HOME/.config/zsh/prompt/prompt.zsh

# diable Ctrl+s (freezes the terminal)
stty -ixon

setopt autocd autopushd # enables .. to go back one dir

HISTFILE=$ZSH_HISTORY
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS  # do not write duplicates to history
setopt HIST_FIND_NO_DUPS  # when searching, do not show duplicates 

# Basic auto/tab complete
autoload -U compinit; compinit # loads a file containing shell commands
_comp_options+=(globdots)  # include hidden files in completions
source $HOME/.config/zsh/completion.zsh  

# vi mode
bindkey -v
export KEYTIMOUT=1 # makes the switch between modes quicker

# Use vim keys in tab complete menu:
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Text objects feature
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Tpope's surround feature
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

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
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Starts ssh-agent to avoid having to enter ssh passphrase every time
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    # Saves passphrase for 8h
    ssh-agent -t 8h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Ruby Version Manager: enables `rails new <project_dir>`
source "/home/rangelgbr/.rvm/scripts/rvm"


# export PYTHONPATH="${PYTHONPATH}:/home/rangelgbr/projects/ogum" 

# load zhs-syntax-highlighting; should be last.
# this seems to be incompatible with tpope's surrounding feature. Let's check...
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
