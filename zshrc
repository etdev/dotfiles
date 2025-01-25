# usr-local
export PATH=$PATH:/usr/local/
export PATH=$PATH:/opt/

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}%{$current_branch%}%{$reset_color%}"
  fi
}
setopt promptsubst
export EDITOR=vim
export VISUAL=vim

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"


# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Add $HOME/.bin and mac_scripts to path
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.mac_scripts:$PATH"

# Source prezto and set to "agnoster" prompt (if installed)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  prompt agnoster
fi

# unalias prezto aliases I don't use
unalias d 2>/dev/null
unalias b 2>/dev/null

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases.kubernetes ]] && source ~/.aliases.kubernetes


unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export TERM=xterm-256color

# Linux-only
  # Set colored output for LS on linux
case $(uname) in
  'Linux')
    LS_OPTIONS='--color=auto' ;
    LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30';
    alias ls='ls --color=auto'
    export LS_COLORS;
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS};;
esac

# Automatically run ls after cd
function chpwd() {
    emulate -L zsh
            ls
}

# Fix colors
autoload -U colors && colors
# Set backup prompt for non-prezto users
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# Set to English UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_us.UTF-8

# vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward
set blink-matching-paren on
export KEYTIMEOUT=1

# hub
eval "$(hub alias -s)"

# check if command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# go
export GOPATH=$HOME/code/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN
export GOGH=$GOPATH/src/github.com/

# php
PATH="/usr/local/opt/php72/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#export PIP_REQUIRE_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if command_exists pyenv ; then eval "$(pyenv init -)"; fi
if command_exists virtualenv && [[ -x "virtualenv" ]] ; then eval "$(pyenv virtualenv-init -)"; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GREP_COLOR='34'
export GREP_COLORS='34'

# rbenv setup
export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
  export PATH="${RBENV_ROOT}/bin:$PATH"
  eval "$(rbenv init -)"
fi

# tmuxinator
if [ -e $HOME/.bin/tmuxinator.zsh ]; then
  source $HOME/.bin/tmuxinator.zsh
fi

# local zshrc
if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# local aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local

# Don't do weird underscore autocompletion for stuff that doesn't exist
zstyle ':completion:*:functions' ignored-patterns '_*'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# load custom executable local functions
if [[ -d $HOME/.zsh/functions_local ]]; then
  for function in ~/.zsh/functions_local/*; do
    if [[ -e $function ]]; then
      source $function
    fi
  done
fi

disable_ruby_warnings() {
  export RUBYOPT="-W0"
  echo "RUBYOPT set"
}

enable_ruby_warnings() {
  unset RUBYOPT
  echo "RUBYOPT unset"
}

# useful variables
export df=$HOME/dotfiles

# add coreutils
#export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# set iTerm profile to etdev-default
echo -e "\033]50;SetProfile=etdev-default\a"

typeset -U path PATH

# Python
PATH=/usr/local/opt/python/libexec/bin:$PATH
# export PATH="$HOME/.anyenv/bin:$PATH"
# eval "$(anyenv init -)"

# Apple Silicon
PATH=/opt/homebrew/opt/python/libexec/bin:$PATH

# Replace with ag
function agr { ag -0 -l "$1" | AGR_FROM="$1" AGR_TO="$2" xargs -0 perl -pi -e 's/$ENV{AGR_FROM}/$ENV{AGR_TO}/g'; }

function json_diff { diff <(cat "$1" | jq '.') <(cat "$2" | jq '.') }
source <(stern --completion=zsh)

function current_timestamp() {
  date -u +"%Y-%m-%d-%H%M"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/etdev/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/etdev/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# Python
# PATH=/usr/local/opt/python/libexec/bin:$PATH
# export PATH="$HOME/.anyenv/bin:$PATH"
# eval "$(anyenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# linkerd
export PATH=$PATH:$HOME/.linkerd2/bin
export PATH=$PATH:/usr/local/Cellar/node/12.3.1/bin/
export PATH=$PATH:/opt/homebrew/Cellar/node/12.3.1/bin/

if [ -f '/Users/etdev/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/etdev/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# Intel Silicon
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# Apple Silicon
export optflags="-Wno-error=implicit-function-declaration"
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

# export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# If you need to have openssl@3 first in your PATH, run:
# echo 'export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"' >> ~/.zshrc
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# 
# For compilers to find openssl@3 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
# 
# For pkg-config to find openssl@3 you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# got
# -> runs for all packages and prints a summary of what happened
# got ./handler
# -> runs for this package and prints a summary
# got ./handler NewPromote
# -> runs for this package and prints a summary
# got ./handler -v
# -> runs and doesn't change the output of `go test`
# got ./handler NewPromote -v
# -> runs and doesn't change the output of `go test`
function got {
    if [[ "$2" == "-v" ]]; then
        go_test "$1" ""
    elif [[ "$3" == "-v" ]]; then
        go_test "$1" "$2"
    else
        TEST_OUTPUT=`go_test "$1" "$2" | ag "^---"`

        FAILED=`echo "$TEST_OUTPUT" | ag "FAIL"`
        FAILED_COUNT=0

        if [[ "$FAILED" != "" ]]; then
            FAILED_COUNT=`echo "$FAILED" | wc -l`
        fi

        PASSED=`echo "$TEST_OUTPUT" | ag "PASS"`
        PASSED_COUNT=0

        if [[ "$PASSED" != "" ]]; then
            PASSED_COUNT=`echo "$PASSED" | wc -l`
        fi

        SKIPED=`echo "$TEST_OUTPUT" | ag "SKIP"`
        SKIPED_COUNT=0

        if [[ "$SKIPED" != "" ]]; then
            SKIPED_COUNT=`echo "$SKIPED" | wc -l`
        fi

        if [[ $FAILED_COUNT -eq 0 ]]; then
            echo "ALL $PASSED_COUNT PASSED";
        else
            echo "$FAILED" | colorize_go_tests
            echo
            echo "$FAILED_COUNT FAILED; $PASSED_COUNT PASSED; $SKIPPED_COUNT SKIPPED"
            echo
        fi
    fi
}

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

run_python_server() {
  python -m http.server $1
}

# Use `jq` with both JSON and non-JSON lines.
function jjq {
    jq -R -r "${1:-.} as \$line | try fromjson catch \$line"
}

# pnpm
export PNPM_HOME="/Users/eric/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun completions
[ -s "/Users/eric/.bun/_bun" ] && source "/Users/eric/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
