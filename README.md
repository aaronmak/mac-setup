# mac-setup

MacOS Development Setup Environment - OSX, ZSH, Homebrew, Vim, Neovim

## Motivation

A modular approach to setting up your Macbook for development.

This repo builds on the awesome work from [Donne Martin](https://github.com/donnemartin) and [Thoughtbot](https://github.com/thoughtbot/).

## Installation

* ZSH [`zsh`]
  * oh-my-zsh [`oh-my-zsh`]
* Homebrew (Includes some helpful binaries and defaults) [`brew`]
* Git config [`git`]
* OSX config [`osx`]
* Applications [`brew-apps`]
* Neovim [`nvim`]

Run the following and select the modules you would like to install.

```shell
./install.sh osxprep zsh oh-my-zsh brew nvim brew-apps git osx
```

Alternatively, use `all` to install all modules.

```shell
./install.sh all
```
