#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

error() { printf "$(date +%FT%T) %b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

temp_dir="$(mktemp -dt "$(basename "$0")".XXXXXX)"
trap 'command rm -rf "$temp_dir"' EXIT INT TERM HUP


configure_tool() {
    tool=$1
    read -p "Do you want to add the ${tool} configuration? (Y/n)" yn
    if [[ -z "$yn" || "$yn" == "Y" || "$yn" == "y" ]]; then
        echo "Configuring ${tool}..."
    fi
}

install_packages() {
    # TODO: make it extend to ubuntu at least, and have ${install_cmd} for diff package managers
    package=$1
    read -p "Do you want to install ${package}? (Y/n)" yn
    if [[ -z "$yn" || "$yn" == "Y" || "$yn" == "y" ]]; then
        # Look for package and get the return code
        # if ! sudo pacman -Ss "$package" | tee "$temp" 2>&1; then
        if ! sudo pacman -Ss "$package" > "$temp_dir/exit_code" 2>&1; then
            echo "$package search failed with error code $?"
            exit 42
        fi
        #
        # Check if search yielded any results by looking at the file size
        if [[ ! -s "$temp_dir/exit_code" ]]; then
            echo "$package not found in repositories."
            exit 42
        fi

    fi

    if hash "$package" &>/dev/null; then
        echo "Package already installed, skipping..."
    else
        sudo pacman -S "$package" && echo "Successfully installed ${package}"
    fi
}



# git clone -b v0.10 https://github.com/neovim/neovim.git "$HOME/.dotfiles/.config/nvim"
# sudo pacman -S neovim # should pull all deps

manifest="$HOME/.dotfiles/dependencies.md"
tools=$("awk $manifest")
pkgs=$("awk $manifest")
configure_tool $1
install_packages $1
