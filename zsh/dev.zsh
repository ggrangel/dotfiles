# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"  # enable auto-activation of virtualenvs

# Ruby Version Manager: enables `rails new <project_dir>`
# source "$HOME/.rvm/scripts/rvm"

# Node version manager
# source /usr/share/nvm/init-nvm.sh

# ruby is necessary to run tmuxinator
export PATH="$PATH:$HOME/.local/share/npm/lib/node_modules/aws-cdk/bin"
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
export PATH="$PATH:$GOPATH/bin"

# Updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-cli/path.zsh.inc' ]; then . '/opt/google-cloud-cli/path.zsh.inc'; fi
# Enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-cli/completion.zsh.inc' ]; then . '/opt/google-cloud-cli/completion.zsh.inc'; fi

# export PATH="$PATH:$CARGO_HOME/bin" # rust
# export PATH="$PATH:$HOME/.rvm/bin" # ruby
# export PATH="$PATH:$PYENV_ROOT/bin" # python
