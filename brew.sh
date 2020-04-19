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

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install homebrew/x11/xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install bat
brew install bitwarden-cli
brew install cmake
brew install dark-mode
brew install entr
brew install fzf
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --xdg
brew install gh
brew install git
brew install git-lfs
brew install git-extras
brew install git-flow
brew install hub
brew install imagemagick
brew install jq
brew install kubernetes-helm
brew install kubectx
brew install lua
brew install lynx
brew install mosh
brew install p7zip
brew install pandoc
brew install peco
brew install pigz
brew install pipenv
brew install pkg-config libffi
brew install pv
brew install pyenv
brew install pyenv-virtualenv
brew install rename
brew install rhino
brew install reattach-to-user-namespace
brew install ripgrep
brew install shellcheck
brew install speedtest-cli
brew install ssh-copy-id
brew install tig
brew install tldr
brew install tree
brew install watch
brew install webkit2png
brew install wifi-password
brew install z
brew install zopfli

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
brew cask install google-cloud-sdk

# Hashicorp tools
brew install terraform

# Remove outdated versions from the cellar.
brew cleanup
