#!/usr/bin/env bash

# Install neovim as a replacement for vim
brew install neovim

# Install vim-plug as plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
