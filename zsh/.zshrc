# Change prompt
fpath=($ZDOTDIR/prompt $fpath)
source $ZDOTDIR/prompt/prompt.zsh

# diable Ctrl+s (freezes the terminal)
stty -ixon

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

eval "$(zoxide init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Ruby Version Manager: enables `rails new <project_dir>`
source "/home/rangelgbr/.rvm/scripts/rvm"

# load zhs-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
