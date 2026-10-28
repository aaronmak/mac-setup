#!/usr/bin/env zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL
source "${0:A:h}/lib/homebrew.sh"
load_homebrew

# Install neovim as a replacement for vim
brew install neovim

# Install packer once; preserve an existing checkout on subsequent runs.
packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [[ ! -d "$packer_dir/.git" ]]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_dir"
fi
