# mac-setup

MacOS Development Setup Environment - OSX, ZSH, Homebrew, Vim, Neovim, asdf

## Motivation

A modular approach to setting up your Macbook for development.

This repo builds on the awesome work from [Donne Martin](https://github.com/donnemartin) and [Thoughtbot](https://github.com/thoughtbot/).

Compatible dotfiles can be found at https://github.com/aaronmak/dotfiles.

## Installation

* ZSH [`zsh`]
* Homebrew (Includes some helpful binaries and defaults) [`brew`]
* Git config [`git`]
* OSX config [`osx`]
* Applications [`brew-apps`]
* Neovim [`nvim`]
* ASDF (version manager for multiple languages) [`asdf`]
* Dockutil (To edit MacOS Dock) [`arrange-dock`]

Run the following and select the modules you would like to install.

```shell
./install.sh osxprep zsh oh-my-zsh brew nvim asdf brew-apps git osx arrange-dock
```

Alternatively, use `all` to install all modules.

```shell
./install.sh all
```
