#!/usr/bin/env bash

# Core casks
brew install --cask xquartz

# Development tool casks
brew install --cask alacritty
brew install --cask android-studio
brew install --cask dash
brew install --cask keycastr
brew install --cask docker
brew install --cask virtualbox
brew install --cask visual-studio-code

# Misc casks
brew install --cask calibre
brew install --cask copyq
brew install --cask disk-inventory-x
brew install --cask fantastical
brew install --cask firefox
brew install --cask gimp
brew install --cask google-chrome
brew install --cask lunar
brew install --cask notion
brew install --cask rectangle
brew install --cask sketch
brew install --cask slack
brew install --cask telegram
brew install --cask whatsapp

# Install Docker, which requires virtualbox
brew install docker
brew install boot2docker

# Install Input Font
brew tap homebrew/cask-fonts
brew install --cask font-input
git clone https://github.com/powerline/fonts.git --depth=1 ~/code/personal/fonts
cd ~/code/personal/fonts || exit
./install.sh
cd ..

# Remove outdated versions from the cellar.
brew cleanup
