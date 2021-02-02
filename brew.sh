#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! "$(brew -v)"; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
brew install gpg
brew install wget

# Install tmux and plugin manager
brew install tmux
brew install tmate
brew install tmuxinator
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install grep
brew install openssh
brew install screen

# Github CLI
brew install gh

# Kubernetes
brew install kubectx

# Hashicorp
brew install terraform
brew install vault

# Python
brew install poetry

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Useful Stuff
brew install bat  # cat alternative
brew install cmake
brew install entr  # runs a command when input changes
brew install exa  # ls replacement
brew install fzf
brew install git  # installs git
brew install jq  # parsing json
brew install lua  # installs lua
brew install mas  # CLI for MacOS App Store
brew install mosh  # ssh alternative (mobile shell)
brew install pandoc  # document conversion
brew install peco  # interactive text filter
brew install reattach-to-user-namespace  # for tmux / vim to work properly with clipboard
brew install ripgrep  # faster grep
brew install shellcheck
brew install speedtest-cli
brew install ssh-copy-id
brew install tig  # git alternative
brew install tldr  # help/man alternative
brew install tree  # displays children paths in tree format
brew install watch  # runs a command on a schedule
brew install z  # faster path navigation

# fzf keybindings
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --xdg --no-bash --no-zsh

# Install ASDF (Extendable Version Manager for multiple language runtime versions)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf || exit
git checkout "$(git describe --abbrev=0 --tags)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit

# Install Google Cloud SDK
curl https://sdk.cloud.google.com > install.sh
bash install.sh --disable-prompts
rm install.sh

# Remove outdated versions from the cellar.
brew cleanup
