#!/usr/bin/env zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL
source "${0:A:h}/lib/homebrew.sh"
load_homebrew

# Core casks
brew install --cask xquartz

# Development tool casks
brew install --cask ghostty
brew install --cask visual-studio-code

# Misc casks
brew install --cask calibre
brew install --cask disk-inventory-x
brew install --cask firefox
brew install --cask gimp
brew install --cask google-chrome
brew install --cask rectangle

# Install mac apps
mas install 1147396723 # Whatsapp Desktop
mas install 1449928544 # Wireless@SGx
mas install 1475387142 # Tailscale
mas install 1480933944 # Vimari
mas install 747648890  # Telegram
mas install 803453959  # Slack

# Install Hack Nerd Font
brew install --cask font-hack-nerd-font
if [[ ! -d "$HOME/code/personal/fonts/.git" ]]; then
	mkdir -p "$HOME/code/personal"
	git clone https://github.com/powerline/fonts.git --depth=1 "$HOME/code/personal/fonts"
fi
cd "$HOME/code/personal/fonts"
./install.sh
cd ..

# Remove outdated versions from the cellar.
brew cleanup
