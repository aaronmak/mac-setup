#!/usr/bin/env bash

function install() {
	# Ask for the administrator password upfront
	sudo -v

	# Keep-alive: update existing `sudo` time stamp until the script has finished
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &

	# Run sections based on command line arguments
	for ARG in "$@"; do
		if [ "$ARG" == "osxprep" ] || [ "$ARG" == "all" ]; then
			# Run the osxprep.sh Script
			echo ""
			echo "------------------------------"
			echo "Updating OSX and installing Xcode command line tools"
			echo "------------------------------"
			echo ""
			./osxprep.sh
		fi
		if [ "$ARG" == "zsh" ] || [ "$ARG" == "all" ]; then
			# Run the zsh.sh Script
			echo ""
			echo "------------------------------"
			echo "Installing zsh to replace bash"
			echo "------------------------------"
			echo ""
			./zsh.sh
		fi
		if [ "$ARG" == "oh-my-zsh" ] || [ "$ARG" == "all" ]; then
			# Run the zsh.sh Script
			echo ""
			echo "------------------------------"
			echo "Installing oh-my-zsh framework"
			echo "------------------------------"
			echo ""
			./oh-my-zsh.sh
		fi
		if [ "$ARG" == "brew" ] || [ "$ARG" == "all" ]; then
			# Run the brew.sh Script
			# For a full listing of installed formulae and apps, refer to
			# the commented brew.sh source file directly and tweak it to
			# suit your needs.
			echo ""
			echo "------------------------------"
			echo "Installing Homebrew along with some common formulae."
			echo "This might take a while to complete, as some formulae need to be installed from source."
			echo "------------------------------"
			echo ""
			./brew.sh
		fi
		if [ "$ARG" == "asdf" ] || [ "$ARG" == "all" ]; then
			# Run the asdf.sh Script
			echo ""
			echo "------------------------------"
			echo "Installing asdf."
			echo "------------------------------"
			echo ""
			./asdf.sh
		fi
		if [ "$ARG" == "nvim" ] || [ "$ARG" == "all" ]; then
			# Run the nvim.sh Script
			echo ""
			echo "------------------------------"
			echo "Installing neovim."
			echo "------------------------------"
			echo ""
			./nvim.sh
		fi
		if [ "$ARG" == "brew-apps" ] || [ "$ARG" == "all" ]; then
			# Run the brew.sh Script
			# For a full listing of installed formulae and apps, refer to
			# the commented brew.sh source file directly and tweak it to
			# suit your needs.
			echo ""
			echo "------------------------------"
			echo "Installing Homebrew cask apps."
			echo "This might take a while to complete, as some formulae need to be installed from source."
			echo "------------------------------"
			echo ""
			./brew-apps.sh
		fi
		if [ "$ARG" == "git" ] || [ "$ARG" == "all" ]; then
			# Run the git.sh Script
			echo ""
			echo "------------------------------"
			echo "Configuring git."
			echo "------------------------------"
			echo ""
			./git.sh
		fi
		if [ "$ARG" == "osx" ] || [ "$ARG" == "all" ]; then
			# Run the osx.sh Script
			# I strongly suggest you read through the commented osx.sh
			# source file and tweak any settings based on your personal
			# preferences. The script defaults are intended for you to
			# customize. For example, if you are not running an SSD you
			# might want to change some of the settings listed in the
			# SSD section.
			echo ""
			echo "------------------------------"
			echo "Setting sensible OSX defaults."
			echo "------------------------------"
			echo ""
			./osx.sh
		fi
		if [ "$ARG" == "arrange-dock" ] || [ "$ARG" == "all" ]; then
			# Run the arrange-dock.sh Script
			# Assumes that the applications are already installed
			echo ""
			echo "------------------------------"
			echo "Adding default dock icons."
			echo "------------------------------"
			echo ""
			./arrange-dock.sh
		fi

		if [ "$ARG" == "npm" ] || [ "$ARG" == "all" ]; then
			# Run the arrange-dock.sh Script
			# Assumes that the applications are already installed
			echo ""
			echo "------------------------------"
			echo "Installing npm stools"
			echo "------------------------------"
			echo ""
			./npm.sh
		fi

	done

	echo "------------------------------"
	echo "Completed running .dots, restart your computer to ensure all updates take effect"
	echo "------------------------------"
}

mkdir -p ~/code/work
mkdir -p ~/code/personal

read -rp "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
	install "$@"
fi

unset install
