# mac-setup

MacOS Development Setup Environment - OSX, ZSH, Homebrew, Vim, Neovim

## Motivation

A modular approach to setting up your Macbook for development.

This repo builds on the awesome work from [Donne Martin](https://github.com/donnemartin) and [Thoughtbot](https://github.com/thoughtbot/).

Compatible dotfiles can be found at <https://github.com/aaronmak/dotfiles>.

## Installation

* Read-only macOS prerequisite check [`osxprep`]
* Homebrew (Includes some helpful binaries and defaults) [`brew`]
* Git Keychain credential helper [`git`]
* Per-user macOS preferences [`osx`]
* Applications [`brew-apps`]
* Neovim [`nvim`]
* npm tools (requires npm to be installed) [`npm`]

Run the following and select the modules you would like to install.

```shell
./install.sh osxprep brew nvim brew-apps git osx
```

Alternatively, use `all` to install all modules.

```shell
./install.sh all
```

Run `./install.sh --help` to list modules. At least one module is required; unknown names are rejected before any changes. Modules run in the requested order, with duplicates skipped. If a module exits with an error, installation stops and reports that module.

The installer can be invoked from any working directory using its path. Review the module scripts before running them, especially the macOS defaults and Dock settings.

The Homebrew bootstrap uses `NONINTERACTIVE=1`. Regular formula installs normally run without confirmation, but casks and their package installers may require administrator access or other interaction. The setup wrapper still prompts for confirmation and `sudo` authentication.

Homebrew's environment is loaded after bootstrap and passed to following modules. Existing plugin and font Git checkouts are preserved on reruns. The Git module checks for the Keychain helper on PATH and in Git's executable directory, and installs Homebrew Git if it is missing.

Run the isolated script checks with `python3 -B -m unittest discover -s tests -v`. These use mocked tools and temporary home directories; they do not install software or change system preferences.

`./osxprep.sh` only checks that a developer directory is selected and exists, and prints where to review macOS updates. It does not install updates or tools, request administrator access, or change settings. A missing or invalid developer directory returns a nonzero exit status so the installer stops before running later modules. This check does not verify that every developer tool works or that Xcode's license has been accepted.

Run `./osxprep.sh` directly for this read-only check. The `install.sh` wrapper still requests administrator access and creates development folders, even when only `osxprep` is selected.

### macOS preferences

Preview settings with `./osx.sh --dry-run`, then apply them with `./osx.sh` as your normal user. Run it directly: the general installer also performs setup beyond settings.

The script changes only per-user preferences: scrollbars and dialogs, local document saves, smart punctuation, tap-to-click and key repeat, screenshots, Finder visibility and list view, Dock appearance and auto-hide, TextEdit plain text, and Activity Monitor display. Comments group the commands by purpose, and each `write` line specifies a preference domain, key, type, and value. Change or remove individual lines to customize them.

It preserves files, Dock pins, and Launchpad layout. It does not install software, reset databases, rebuild Spotlight, terminate apps, change machine identity or region, modify power management, or disable security prompts. Obsolete debug tweaks and app-specific browser/mail policies have been removed. Existing settings from older runs are not automatically restored.

Applying preferences replaces the named values; it is not a backup or undo system. On a write failure, the script stops with an error; earlier writes remain applied. Reopen apps or log out when convenient. Some preference keys are undocumented and may be ignored on different macOS releases, so a successful write does not guarantee a visible effect.
