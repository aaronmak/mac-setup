# mac-setup

MacOS Development Setup Environment - OSX, ZSH, Homebrew, Vim, Neovim

## Motivation

A modular approach to setting up your Macbook for development.

This repo builds on the awesome work from [Donne Martin](https://github.com/donnemartin) and [Thoughtbot](https://github.com/thoughtbot/).

Compatible dotfiles can be found at <https://github.com/aaronmak/dotfiles>.

## Installation

* macOS updates and Xcode command line tools [`osxprep`]
* Homebrew (Includes some helpful binaries and defaults) [`brew`]
* Git config [`git`]
* OSX config [`osx`]
* Applications [`brew-apps`]
* Neovim [`nvim`]
* Dockutil (To edit MacOS Dock) [`arrange-dock`]
* npm tools (requires npm to be installed) [`npm`]

Run the following and select the modules you would like to install.

```shell
./install.sh osxprep brew nvim brew-apps git osx arrange-dock
```

Alternatively, use `all` to install all modules.

```shell
./install.sh all
```

Run `./install.sh --help` to list modules. At least one module is required; unknown names are rejected before any changes. Modules run in the requested order, with duplicates skipped. If a module exits with an error, installation stops and reports that module.

The installer can be invoked from any working directory using its path. Review the module scripts before running them, especially the macOS defaults and Dock settings.
