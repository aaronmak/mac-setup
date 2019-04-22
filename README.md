# mac-setup

MacOS Development Setup Environment - ZSH, Homebrew, Python, Ruby, JS, Visual Studio Code, Google Cloud

## Motivation

A modular approach to setting up your Macbook for development with extensive, yet simple, documentation.

This repo builds on the awesome work from [Donne Martin](https://github.com/donnemartin) and [Thoughtbot](https://github.com/thoughtbot/).

## Installation

* ZSH [`zsh`]
  * oh-my-zsh [`oh-my-zsh`]
* Homebrew (Includes some helpful binaries and defaults) [`brew`]
* Bootstrap Dotfiles [`bootstrap`]
  * .aliases - Helpful shortcuts
  * .editorconfig - Configures text editor settings
    -- [Documentation](https://editorconfig.org)
  * .exports - Helpful exports
  * .functions - Helpful functions
  * .gitignore_global - Creates a global gitignore file
  * .hushlogin - Disables message of the day
  * .inputrc - Configures the readline library to customize the command line user interface
    -- [Documentation](https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File.html)
  * .screenrc - Configures your terminal screen
    -- [Documentation](http://www.gnu.org/software/screen/manual/screen.html#Startup-Files)
* Git config [`git`]
* OSX config [`osx`]
* Text Editors
  * Visual Studio Code
  * Vim
* Programming Languages - ASDF for managing programming language versions
  * Python
  * Ruby
  * JavaScript
  * Go
* Applications [`brew-apps`]

Run the following and select the modules you would like to install.

```shell
./.dots.sh bootstrap osxprep zsh oh-my-zsh brew brew-apps git osx
```
