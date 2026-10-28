# mac-setup

Modular macOS development setup with Zsh, Homebrew, Git, Vim, and Neovim.

## Motivation

A modular approach to setting up your Mac for development.

This repo builds on the awesome work from [Donne
Martin](https://github.com/donnemartin) and
[Thoughtbot](https://github.com/thoughtbot/).

Compatible dotfiles can be found at <https://github.com/aaronmak/dotfiles>.

## Installation

Run these commands from a local checkout on macOS. The scripts require Zsh.

| Module | Script | Purpose |
| --- | --- | --- |
| `osxprep` | [osxprep.sh](osxprep.sh) | Read-only macOS prerequisite check |
| `brew` | [brew.sh](brew.sh) | Homebrew and development tools |
| `nvim` | [nvim.sh](nvim.sh) | Neovim |
| `brew-apps` | [brew-apps.sh](brew-apps.sh) | Applications and fonts |
| `git` | [git.sh](git.sh) | Git Keychain credential helper |
| `osx` | [osx.sh](osx.sh) | Per-user macOS preferences |
| `npm` | [npm.sh](npm.sh) | Mermaid CLI; requires npm to be installed |

Choose modules by passing their names to the installer:

```shell
./install.sh osxprep brew nvim brew-apps git osx
```

Alternatively, use `all` to run every module in the order shown above. Install
Node.js and npm first if you include the `npm` module:

```shell
./install.sh all
```

Run `./install.sh --help` to list modules. At least one module is required;
unknown names are rejected before any changes. Modules run in the requested
order, with duplicates skipped. If a module exits with an error, installation
stops and reports that module.

The installer can be invoked from any working directory using its path. Review
the module scripts before running them, especially the macOS defaults and Dock
settings.

The Homebrew bootstrap uses `NONINTERACTIVE=1`. Regular formula installs
normally run without confirmation, but casks and their package installers may
require administrator access or other interaction. The setup wrapper still
prompts for confirmation and `sudo` authentication.

Homebrew's environment is loaded after bootstrap and passed to following
modules. Existing plugin and font Git checkouts are preserved on reruns. The Git
module checks for the Keychain helper on PATH and in Git's executable directory,
and installs Homebrew Git if it is missing.

### macOS prerequisite check

`./osxprep.sh` only checks that a developer directory is selected and exists,
and prints where to review macOS updates. It does not install updates or tools,
request administrator access, or change settings. A missing or invalid developer
directory returns a nonzero exit status so the installer stops before running
later modules. This check does not verify that every developer tool works or
that Xcode's license has been accepted.

Run `./osxprep.sh` directly for this read-only check. The `install.sh` wrapper
still requests administrator access and creates development folders, even when
only `osxprep` is selected.

### macOS preferences

Preview settings with `./osx.sh --dry-run`, then apply them with `./osx.sh` as
your normal user. Run it directly: the general installer also performs setup
beyond settings.

The script changes only per-user preferences: scrollbars and dialogs, local
document saves, smart punctuation, tap-to-click and key repeat, screenshots,
Finder visibility and list view, Dock appearance and auto-hide, TextEdit plain
text, and Activity Monitor display. Comments group the commands by purpose, and
each `write` line specifies a preference domain, key, type, and value. Change or
remove individual lines to customize them.

It preserves files, Dock pins, and Launchpad layout. It does not install
software, reset databases, rebuild Spotlight, terminate apps, change machine
identity or region, modify power management, or disable security prompts.
Obsolete debug tweaks and app-specific browser/mail policies have been removed.
Existing settings from older runs are not automatically restored.

Applying preferences replaces the named values; it is not a backup or undo
system. On a write failure, the script stops with an error; earlier writes
remain applied. Reopen apps or log out when convenient. Some preference keys are
undocumented and may be ignored on different macOS releases, so a successful
write does not guarantee a visible effect.

## Development

With mise available on your PATH, run these commands from the repository root:

```shell
mise trust
mise install
mise run lint
mise run hooks:install
```

[mise.toml](mise.toml) pins hk, Node.js, markdownlint-cli2, and ShellCheck.
`mise run lint` checks all tracked Markdown and shell files. The hook
installation applies to the current clone; pre-commit checks run on staged files
using [hk.pkl](hk.pkl).

Markdown files use markdownlint-cli2. ShellCheck checks compatible shell files;
Zsh scripts use `zsh -n` for syntax checking.

Run the isolated script tests with Python 3:

```shell
python3 -B -m unittest discover -s tests -v
```

The tests use mocked tools and temporary home directories; they do not install
software or change system preferences.
