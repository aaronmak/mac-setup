#!/usr/bin/env zsh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

# Install git-credential-osxkeychain
if test ! "$(command -v git credential-osxkeychain)"; then
	echo "Installing git-credential-osxkeychain..."
	curl -O http://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain
	mv git-credential-osxkeychain /usr/local/bin/
	chmod u+x /usr/local/bin/git-credential-osxkeychain
fi
