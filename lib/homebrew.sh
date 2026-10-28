# Load Homebrew into the current shell, including immediately after bootstrap.
load_homebrew() {
	local brew_bin
	brew_bin=$(command -v brew) || brew_bin=''
	if [[ -z $brew_bin ]]; then
		if [[ -x /opt/homebrew/bin/brew ]]; then
			brew_bin=/opt/homebrew/bin/brew
		elif [[ -x /usr/local/bin/brew ]]; then
			brew_bin=/usr/local/bin/brew
		else
			return 1
		fi
	fi
	local brew_env
	brew_env=$("$brew_bin" shellenv) || return $?
	eval "$brew_env"
}
