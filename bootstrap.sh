#!/bin/bash
# Exit as soon as any one of these commands fails
set -e
# Print commands as they're being run
set -x
function setup_dotfiles() {
    git clone --depth=1 https://github.com/jaysh/dotfiles ~/dotfiles
    cd ~/dotfiles
    ./setup.sh
}

setup_dotfiles
