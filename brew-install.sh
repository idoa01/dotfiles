#!/bin/bash
#
# Setup new mac machine with brew and applications
#

# make sure Homebrew is installed
if ! which brew > /dev/null; then
  # Install Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Update brew
brew update

# Install everything in Brewfile
brew bundle
