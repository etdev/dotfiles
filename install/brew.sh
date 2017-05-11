#!/usr/bin/env bash

# install homebrew if not installed yet
command -v brew >/dev/null 2>&1 || { \
  echo >&2 "Installing brew..."; \
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

# tap repos
while read repo_name; do
  echo $repo_name;
  brew tap $repo_name;
done <brew_repos.txt
brew tap homebrew/versions

# install packages
while read package; do
  echo $package;
  brew install $package;
done <brew_packages.txt

# install cask packages
while read application; do
  echo $application;
  brew cask install $application;
done <brew_cask.txt
