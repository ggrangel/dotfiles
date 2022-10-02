# Change prompt
fpath=($ZDOTDIR/prompt $fpath)
source $HOME/.config/zsh/prompt/prompt.zsh

# disable Ctrl+s (freezes the terminal)
stty -ixon

# easy navigation
export _ZO_ECHO=1 # z will print the matched directory before navigating to it.
eval "$(zoxide init zsh)"
setopt autocd autopushd # enables .. to go back one dir

HISTFILE=$HOME/.cache/zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS  # do not write duplicates to history
setopt HIST_FIND_NO_DUPS  # when searching, do not show duplicates 

# Basic auto/tab complete
autoload -U compinit; compinit # loads a file containing shell commands
_comp_options+=(globdots)  # include hidden files in completions
source $ZDOTDIR/completion.zsh  

[ -f "$ZDOTDIR/vi.zsh" ] && source "$ZDOTDIR/vi.zsh"

[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"

[ -f "$ZDOTDIR/proxy.zsh" ] && source "$ZDOTDIR/proxy.zsh"

[ -f "$ZDOTDIR/dev.zsh" ] && source "$ZDOTDIR/dev.zsh"

# make a new directory and cd to it
mkd () {
    # -- makes sure the passed name for the new direcxtory is not interpreted as an option to mkdir or cd
    # -P used on cd resolves symbolink links.
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}


# load zhs-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
