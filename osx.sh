#!/usr/bin/env zsh

# Personal, per-user preferences. Preview with ./osx.sh --dry-run.
# Some defaults keys are undocumented and may be ignored by newer macOS versions.
setopt ERR_EXIT NO_UNSET PIPE_FAIL

usage() {
	print -- "Usage: osx.sh [--dry-run | --help]"
	print -- "Apply per-user macOS preferences, or preview commands without changes."
}

dry_run=false
case $# in
	0) ;;
	1)
		case $1 in
			--dry-run) dry_run=true ;;
			--help|-h) usage; exit 0 ;;
			*) usage >&2; exit 2 ;;
		esac ;;
	*) usage >&2; exit 2 ;;
esac

if [[ $OSTYPE != darwin* ]]; then
	print -ru2 -- "osx requires macOS."
	exit 1
fi
if (( EUID == 0 )); then
	print -ru2 -- "Run this script as your normal user, without sudo."
	exit 1
fi

write() {
	if $dry_run; then
		printf '%q ' defaults write "$@"
		printf '\n'
	else
		if ! defaults write "$@"; then
			print -ru2 -- "Failed to write preference: $1 / $2. Earlier changes remain applied."
			exit 1
		fi
	fi
}

# General: expanded dialogs, local saves, literal punctuation.
write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Input: natural scrolling, full keyboard access, fast key repeat.
write NSGlobalDomain com.apple.swipescrolldirection -bool true
write NSGlobalDomain AppleKeyboardUIMode -int 3
write NSGlobalDomain ApplePressAndHoldEnabled -bool false
write NSGlobalDomain KeyRepeat -int 1
write NSGlobalDomain InitialKeyRepeat -int 15

# Screenshots: PNG on the Desktop, without window shadows.
write com.apple.screencapture location -string "$HOME/Desktop"
write com.apple.screencapture type -string png
write com.apple.screencapture disable-shadow -bool true

# Finder: visible files/extensions, path/status bars, list view, local search.
write com.apple.finder AppleShowAllFiles -bool true
write NSGlobalDomain AppleShowAllExtensions -bool true
write com.apple.finder ShowStatusBar -bool true
write com.apple.finder ShowPathbar -bool true
write com.apple.finder FXDefaultSearchScope -string SCcf
write com.apple.finder FXPreferredViewStyle -string Nlsv
write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
write com.apple.finder ShowHardDrivesOnDesktop -bool true
write com.apple.finder ShowMountedServersOnDesktop -bool true
write com.apple.finder ShowRemovableMediaOnDesktop -bool true
write NSGlobalDomain com.apple.springing.enabled -bool true
write NSGlobalDomain com.apple.springing.delay -float 0.5
write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Dock: small icons, scale animation, auto-hide, stable Spaces order.
# Existing pinned applications and Launchpad layout are preserved.
write com.apple.dock tilesize -int 36
write com.apple.dock mineffect -string scale
write com.apple.dock show-process-indicators -bool true
write com.apple.dock launchanim -bool false
write com.apple.dock expose-group-by-app -bool false
write com.apple.dock mru-spaces -bool false
write com.apple.dock autohide-delay -float 0
write com.apple.dock autohide-time-modifier -float 0
write com.apple.dock autohide -bool true

if $dry_run; then
	print -- "Preview complete. No settings were changed."
else
	print -- "Preferences written. Reopen apps or log out when convenient to apply them."
fi
