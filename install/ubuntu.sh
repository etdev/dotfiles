#!/bin/bash

for package in $(cat ./ubuntu_packages.txt); do
  sudo apt-get update
  if [[ $(apt-cache search --names-only "^$package$") ]]; then
    echo Installing $package...
    sudo apt-get -y install $package
  fi
done
