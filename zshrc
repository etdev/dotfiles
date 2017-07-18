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

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

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
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.mac_scripts:$PATH"

# Source prezto and set to "agnoster" prompt (if installed)
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  prompt agnoster
fi

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
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN
export GOGH=$GOPATH/src/github.com/

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIP_REQUIRE_VIRTUALENV=true
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
    source $function
  done
fi

# useful variables
export df=$HOME/dotfiles
