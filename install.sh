#!/usr/bin/env zsh

# Resolve module paths independently of the caller's working directory.
SCRIPT_DIR=${0:A:h}

usage() {
	print -r -- "Usage: $0 <module> [module ...]"
	print -r -- "Modules: osxprep brew nvim brew-apps git osx arrange-dock npm"
	print -r -- "Use all to run every module, or --help for this message."
}

cleanup() {
	if [[ -n $SUDO_KEEPALIVE_PID ]]; then
		kill "$SUDO_KEEPALIVE_PID" 2>/dev/null
		wait "$SUDO_KEEPALIVE_PID" 2>/dev/null
	fi
	return 0
}

main() {
	local arg module result reply
	local -a modules
	local -a all_modules=(osxprep brew nvim brew-apps git osx arrange-dock npm)

	if (( $# == 0 )); then
		usage >&2
		return 2
	fi
	if (( $# == 1 )) && [[ $1 == --help || $1 == -h ]]; then
		usage
		return 0
	fi

	# Validate every argument before prompting or making changes.
	for arg in "$@"; do
		case $arg in
			all) modules+=("${all_modules[@]}") ;;
			osxprep|brew|nvim|brew-apps|git|osx|arrange-dock|npm)
				modules+=("$arg") ;;
			*)
				print -ru2 -- "Unknown module: $arg"
				usage >&2
				return 2 ;;
		esac
	done
	# Run repeated modules only once, preserving their requested order.
	modules=("${(@u)modules}")
	for module in "${modules[@]}"; do
		if [[ ! -x "$SCRIPT_DIR/$module.sh" ]]; then
			print -ru2 -- "Module script is missing or not executable: $SCRIPT_DIR/$module.sh"
			return 1
		fi
	done

	printf '%s' 'This script may overwrite existing files in your home directory. Are you sure? (y/n) '
	if ! read -r reply; then
		print -ru2 -- "No confirmation received; installation cancelled."
		return 1
	fi
	if [[ $reply != [Yy] ]]; then
		print -- "Installation cancelled."
		return 0
	fi

	sudo -v || return $?
	# Keep sudo credentials alive, and stop the helper when this script exits.
	(
		local sleep_pid
		trap '[[ -z $sleep_pid ]] || kill "$sleep_pid" 2>/dev/null; exit 0' TERM INT
		while true; do
			sleep 60 &
			sleep_pid=$!
			wait "$sleep_pid"
			sudo -n true || exit
		done
	) 2>/dev/null &
	SUDO_KEEPALIVE_PID=$!

	mkdir -p "$HOME/code/work" "$HOME/code/personal" || return $?
	for module in "${modules[@]}"; do
		print -r -- "Running $module..."
		# Also give legacy module scripts a consistent working directory.
		(cd "$SCRIPT_DIR" && "./$module.sh")
		result=$?
		if (( result != 0 )); then
			print -ru2 -- "Module $module failed (exit $result). Installation stopped."
			return "$result"
		fi
	done
	print -- "Completed mac-setup. Restart your computer to ensure all updates take effect."
}

SUDO_KEEPALIVE_PID=''
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
main "$@"
exit $?
