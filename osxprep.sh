#!/usr/bin/env zsh

# Read-only prerequisite check. Updates and installations are manual choices.
if [[ $OSTYPE != darwin* ]]; then
	print -ru2 -- "osxprep requires macOS."
	exit 1
fi

print -- "Review macOS updates in System Settings > General > Software Update."

if developer_dir=$(xcode-select --print-path 2>/dev/null) && [[ -d $developer_dir ]]; then
	print -r -- "Selected developer directory: $developer_dir"
else
	print -ru2 -- "No valid developer directory is selected."
	print -ru2 -- "To install command line tools manually, run: xcode-select --install"
	print -ru2 -- "If Xcode is already installed, select it in Xcode > Settings > Locations."
	exit 1
fi
