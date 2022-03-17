#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Install if we don't have it
if test ! "$(brew -v)"; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if test ! "$(dockutil --version)"; then
  echo "Installing dockutil..."
  brew install dockutil
fi

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

dockutil --add /Applications/Safari.app --no-restart --position 2
dockutil --add /Applications/Telegram.app --no-restart --position 3
dockutil --add /Applications/WhatsApp.app --no-restart --position 4
dockutil --add /Applications/Notion.app --no-restart --position 5
dockutil --add /Applications/Dash.app --no-restart --position 6
dockutil --add /Applications/calibre.app --no-restart --position 7
dockutil --add /Applications/Slack.app --no-restart --position 8
dockutil --add /Applications/Mail.app --no-restart --position 9
dockutil --add '/Applications/Visual Studio Code.app' --no-restart --position 9
dockutil --add /Applications/Alacritty.app --no-restart --position 10

dockutil --add "${HOME}/code" --no-restart --position 1

killall Dock
