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
  sh ./install_mac.sh
elif [ "$platform" == "linux" ]; then
  sh ./install_linux.sh
fi
