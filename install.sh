#!/usr/bin/env bash
# check platform
if [ "$(uname)" == "Darwin" ]; then
    # mac
    platform="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # linux
    platform="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # quit if someone tries to run this on Windows
    exit
fi

# install mac components
if [ "$platform" == "mac" ]; then
  # brew
  sh ./install/brew.sh
fi

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# migrate files using rcup
env RCRC=$HOME/dotfiles/rcrc rcup

# set zsh theme
/bin/cp zsh/agnoster.zsh-theme ~/.zprezto/modules/prompt/external/agnoster/agnoster.zsh-theme
