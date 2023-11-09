# dir
DOTFIELS_DIR="$HOME/dotfiles"

source "$HOME/.zplug/init.zsh"
source "$DOTFIELS_DIR/config/zplugs.zsh"

# コマンドの履歴機能
# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=10000
# HISTFILE で指定したファイルに保存される履歴の件数
SAVEHIST=10000
# Then, source plugins and add commands to $PATH

# abbrevにしたい
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gsw='git switch'
alias gp='git push'
alias gpf='git push --force-with-lease origin'
alias gb='git branch'
alias gl='git log'
alias dc="docker compose"
alias ls="ls"
alias ll="ls -al"

#git config
alias open="nvim"
alias pbcopy='xsel --clipboard --input'
alias reload="source ~/.zshrc && tmux source ~/.tmux.conf"
alias reset="sudo hwclock -s"
alias dui="lazydocker"
alias kusa='curl https://github-contributions-api.deno.dev/$(git config user.name).term'
alias nyarn='echo "😺「にゃーん」" && yarn'
alias cheatlist="$DOTFIELS_DIR/command/cheatsheet/script.sh $DOTFIELS_DIR/command/cheatsheet/.commands.yml"
alias ide="$DOTFIELS_DIR/command/ide.sh"

# change directory
alias ..="cd .."
alias dc="dotfiles && nvim"

PURE_PROMPT_SYMBOL='%F{cyan}'
# PROMPT='%F{cyan} %F{color}%n %F{cyan} %F{clor}%~ %F{cyan}
# %F{color}$%f '

# fzf setting {{{
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}


# history, aliasからコマンドを検索する
function search_history() {
  BUFFER=$({ \
    # cheatlist 2>/dev/null; \
    alias | grep -oP "(?<=')[^']*(?=')"; \
    history -n -r 1 | awk '!a[$0]++'} \
    | fzf +s +m -q "$LBUFFER" --prompt="Search History... ")
  CURSOR=$#BUFFER
}
zle -N search_history
bindkey '^r' search_history

function search_cheatsheet() {
  BUFFER=$(cheatlist 2>/dev/null| fzf +s +m -q "$LBUFFER" --prompt="Search CheatSheet... ")
  CURSOR=$#BUFFER
}
zle -N search_cheatsheet
bindkey '^;' search_cheatsheet

# ctrl-a, ctrl-eがtmux上で使えない問題の対応
bindkey -e

fpath=(path/to/zsh-completions/src $fpath)
