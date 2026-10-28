#!/usr/bin/env zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL

has_keychain_helper() {
	command -v git-credential-osxkeychain >/dev/null 2>&1 && return 0
	command -v git >/dev/null 2>&1 || return 1
	local exec_dir
	exec_dir=$(git --exec-path) || return $?
	[[ -x "$exec_dir/git-credential-osxkeychain" ]]
}

# Modern Git distributions include the helper; avoid the legacy HTTP binary.
if ! has_keychain_helper; then
	source "${0:A:h}/lib/homebrew.sh"
	load_homebrew
	brew install git
	if ! has_keychain_helper; then
		print -ru2 -- "git-credential-osxkeychain is unavailable after installing Git."
		exit 1
	fi
fi
