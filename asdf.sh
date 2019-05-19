#!/usr/bin/env bash

# Install ASDF version manager for multiple languages

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install ASDF (Extendable Version Manager for multiple language runtime versions)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout master
git fetch -p
git checkout "$(git describe --abbrev=0 --tags)"
