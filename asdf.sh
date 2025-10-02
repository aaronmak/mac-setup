#!/usr/bin/env zsh

# Install ASDF version manager for multiple languages

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# Install ASDF (Extendable Version Manager for multiple language runtime versions)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

# Install common plugins
asdf plugin-add python
asdf plugin-add nodejs
asdf plugin-add haskell
asdf plugin-add ruby
asdf plugin-add rust
asdf plugin-add R
