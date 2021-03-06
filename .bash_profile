export LANG=ja_JP.UTF-8

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

export GOPATH=${HOME}/go
export PATH="${GOPATH}/bin:${PATH}"

export BAT_THEME="base16"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

source "$HOME/google-cloud-sdk/completion.bash.inc"
source "$HOME/google-cloud-sdk/path.bash.inc"

eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"
  eval "$(pyenv virtualenv-init -)"
fi

# brew path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

