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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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

# Install kube-tmux status line
git clone https://github.com/jonmosco/kube-tmux.git ~/.tmux/kube-tmux
ln -s ~/.tmux/kube-tmux/kube.tmux ~/.tmux/kube.tmux

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
brew install vault

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Useful Stuff
brew install bat  # cat alternative
brew install saml2aws  # login to AWS
brew install cmake
brew install entr  # runs a command when input changes
brew install exa  # ls replacement
brew install fd # find replacement
brew install fzf
brew install git  # installs git
brew install jq  # parsing json
brew install lua  # installs lua
brew install mas  # CLI for MacOS App Store
brew install mosh  # ssh alternative (mobile shell)
brew install node-build  # for nodejs
brew install pandoc  # document conversion
brew install peco  # interactive text filter
brew install pipx  # use python apps in isolated envs
brew install postgresql
brew install qmk/qmk/qmk  # keyboard config
brew install reattach-to-user-namespace  # for tmux / vim to work properly with clipboard
brew install ripgrep  # faster grep
brew install shellcheck
brew install speedtest-cli
brew install ssh-copy-id
brew install starship  # fast terminal prompt
brew install tealdeer  # help/man alternative
brew install tig  # git alternative
brew install watch  # runs a command on a schedule
brew install zoxide  # faster path navigation
brew install zsh-autosuggestions
pipx ensurepath

# fzf keybindings
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --xdg --no-bash --no-zsh

# Install poetry
curl -sSL https://install.python-poetry.org | python3 -

# Install python-lsp-server
pipx install 'python-lsp-server[all]'

# Remove outdated versions from the cellar.
brew cleanup
