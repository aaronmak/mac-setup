#!/usr/bin/env zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL

# Install command-line tools using Homebrew.

source "${0:A:h}/lib/homebrew.sh"

if ! load_homebrew; then
	echo "Installing homebrew..."
	installer=$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
	NONINTERACTIVE=1 /bin/bash -c "$installer"
	load_homebrew
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
brew_prefix=$(brew --prefix)
checksum_link="$brew_prefix/bin/sha256sum"
if [[ -L $checksum_link || ! -e $checksum_link ]]; then
	ln -sfn "$brew_prefix/bin/gsha256sum" "$checksum_link"
else
	print -ru2 -- "Refusing to replace existing file: $checksum_link"
	exit 1
fi

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
if [[ ! -d "$HOME/.tmux/plugins/tpm/.git" ]]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install kube-tmux status line
if [[ ! -d "$HOME/.tmux/kube-tmux/.git" ]]; then
	git clone https://github.com/jonmosco/kube-tmux.git "$HOME/.tmux/kube-tmux"
fi
if [[ ! -e "$HOME/.tmux/kube.tmux" && ! -L "$HOME/.tmux/kube.tmux" ]]; then
	ln -s "$HOME/.tmux/kube-tmux/kube.tmux" "$HOME/.tmux/kube.tmux"
fi

# Install more recent versions of some OS X tools.
brew install vim
brew install grep
brew install openssh
brew install screen

# Github CLI
brew install gh

# Kubernetes
brew install kubectx

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Lua
brew install luarocks

# 1Password
brew install 1password-cli

# Useful Stuff
brew install atuin # synced history
brew install bat   # cat alternative
brew install cmake
brew install duckdb # fast local OLAP database, good for debugging
brew install entr   # runs a command when input changes
brew install eza    # ls replacement
brew install fd     # find replacement
brew install fzf
brew install ghostscript # postscript / pdf interpreter
brew install git        # installs git
brew install hk         # git hook and pre-commit lint manager
brew install imagemagick # image maniplulation
brew install jq         # parsing json
brew install lua        # installs lua
brew install mas        # CLI for MacOS App Store
brew install pandoc     # document conversion
brew install peco       # interactive text filter
brew install postgresql
brew install qmk/qmk/qmk                # keyboard config
brew install reattach-to-user-namespace # for tmux / vim to work properly with clipboard
brew install ripgrep                    # faster grep
brew install rtk  # save tokens
brew install saml2aws                   # login to AWS
brew install shellcheck
brew install speedtest-cli
brew install ssh-copy-id
brew install starship # fast terminal prompt
brew install tealdeer # help/man alternative
brew install tig      # git alternative
brew install usage   # spec for defining CLI tools
brew install watch    # runs a command on a schedule
brew install zoxide   # faster path navigation
brew install zsh-autosuggestions
brew install pipx
pipx ensurepath

# fzf keybindings
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --xdg --no-bash --no-zsh

# Install mise
curl -fsSL https://mise.run | sh

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install claude code
curl -fsSL https://claude.ai/install.sh | bash

# Remove outdated versions from the cellar.
brew cleanup
