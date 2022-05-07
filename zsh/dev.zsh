export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Ruby Version Manager: enables `rails new <project_dir>`
source "/home/rangelgbr/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$PYENV_ROOT/bin"
