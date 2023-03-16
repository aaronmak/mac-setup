#!/usr/bin/env bash

# Core casks
brew install --cask xquartz

# Development tool casks
brew install --cask alacritty
brew install --cask android-studio
brew install --cask dash
brew install --cask keycastr
brew install --cask docker
brew install --cask visual-studio-code

# Misc casks
brew install --cask 1password/tap/1password-cli
brew install --cask alfred
brew install --cask calibre
brew install --cask disk-inventory-x
brew install --cask firefox
brew install --cask gimp
brew install --cask google-chrome
brew install --cask lunar
brew install --cask rectangle

# Install mac apps
mas install 1147396723  # Whatsapp Desktop
mas install 1278508951  # Trello
mas install 1449928544  # Wireless@SGx
mas install 1475387142  # Tailscale
mas install 1480933944  # Vimari
mas install 409183694   # Keynote
mas install 409201541   # Pages
mas install 409203825   # Numbers
mas install 747648890   # Telegram
mas install 803453959   # Slack
mas install 937984704   # Amphetamine

# Install Hack Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
git clone https://github.com/powerline/fonts.git --depth=1 ~/code/personal/fonts
cd ~/code/personal/fonts || exit
./install.sh
cd ..

# Remove outdated versions from the cellar.
brew cleanup
