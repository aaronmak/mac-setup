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

# Install tmux and plugin manage
brew install tmux
brew install tmate
brew install tmuxinator
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install grep
brew install openssh
brew install screen

# Install other useful binaries.
brew install ack
brew install bat
brew install bitwarden-cli
brew install cmake
brew install entr
brew install fzf
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --xdg
brew install gh
brew install git
brew install hub
brew install imagemagick
brew install jq
brew install kubectx
brew install lua
brew install lynx
brew install mosh
brew install pandoc
brew install peco
brew install reattach-to-user-namespace
brew install ripgrep
brew install shellcheck
brew install speedtest-cli
brew install ssh-copy-id
brew install tig
brew install tldr
brew install tree
brew install watch
brew install wifi-password
brew install z
brew install zopfli

# Python tools
brew install poetry
brew install pyenv

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Install Heroku
brew install heroku/brew/heroku
heroku update

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase qlvideo

# Install FiraCode
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew cask install font-input

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

# Hashicorp tools
brew install terraform

# Remove outdated versions from the cellar.
brew cleanup
