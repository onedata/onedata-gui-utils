#!/bin/bash

set -euo pipefail

ALIAS_LINE='alias dev="cd `git rev-parse --show-toplevel` && ./onedata-gui-utils/scripts/dev.sh"'

detect_shell_rc() {
	local shell_name
	shell_name="$(basename "${SHELL:-}")"

	case "$shell_name" in
		zsh)
			echo "$HOME/.zshrc"
			;;
		bash)
			echo "$HOME/.bashrc"
			;;
		fish)
			echo "$HOME/.config/fish/config.fish"
			;;
		*)
			echo "$HOME/.profile"
			;;
	esac
}

RC_FILE="$(detect_shell_rc)"

mkdir -p "$(dirname "$RC_FILE")"
touch "$RC_FILE"

if grep -Fxq "$ALIAS_LINE" "$RC_FILE"; then
	echo "Alias already present in $RC_FILE"
	exit 0
fi

if grep -Eq '^alias[[:space:]]+dev=' "$RC_FILE"; then
	echo "An alias named 'dev' already exists in $RC_FILE. Skipping add."
	exit 0
fi

printf '\n%s\n' "$ALIAS_LINE" >> "$RC_FILE"
echo "Added alias to $RC_FILE"
