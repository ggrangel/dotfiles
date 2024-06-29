# Change prompt
fpath=("$ZDOTDIR/prompt" $fpath)
source "$HOME/.config/zsh/prompt/prompt.zsh"

# disable Ctrl+s (freezes the terminal)
stty -ixon
# run bindkey for a list of zsh keybindings
bindkey -r "^D" # used to kill tmux pane and window. remove this zsh keybinding

setopt AUTOCD             # enables .. to go back one dir
setopt AUTOPUSHD          # push the curr dir visited to stack
setopt HIST_IGNORE_DUPS   # do not write duplicates to history
setopt HIST_FIND_NO_DUPS  # when searching, do not show duplicates
setopt INC_APPEND_HISTORY # allows sharing of history between concurrent shells
unsetopt BEEP             # turn off all beeps
# unsetopt LIST_BEEP # turn off only autocomplete beeps

HISTFILE=$HOME/.cache/zsh_history
HISTSIZE=10000 # max events for internal history
SAVEHIST=10000 # max events in history file

# Basic auto/tab complete

autoload -U compinit
compinit
_comp_options+=(globdots) # With hidden files
[ -f "$ZDOTDIR/completion.zsh" ] && source "$ZDOTDIR/completion.zsh"

[ -f "$ZDOTDIR/vi.zsh" ] && source "$ZDOTDIR/vi.zsh"

[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

[ -f "$ZDOTDIR/dev.zsh" ] && source "$ZDOTDIR/dev.zsh"

[ -f "$ZDOTDIR/secret.zsh" ] && source "$ZDOTDIR/secret.zsh"

# save zoxide database on a drive folder according to the machine you're
host_name=$(cat /etc/hostname)
export _ZO_DATA_DIR="$HOME/drive/.local/share/zoxide/$host_name"
export _ZO_ECHO=1 # z will print the matched directory before navigating to it.
eval "$(zoxide init zsh)"

# ^r to activate mcfly
eval "$(mcfly init zsh)"
export MCFLY_KEY_SCHEME=vim

# deduplicate entries in $PATH
export PATH=$(echo $PATH | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':')

# load zhs-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
