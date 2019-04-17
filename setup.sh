#!/bin/bash
# Exit as soon as any one of these commands fails
set -e
# Print commands as they're being run
set -x

function vim_from_source() {
    sudo apt -y remove vim
    sudo apt -y install libevent-dev ncurses-dev
    git clone --depth=1 https://github.com/vim/vim.git
    cd vim
    make
    sudo make install
    cd ..
    rm -rf vim

    # fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # silver searcher
    sudo apt -y install silversearcher-ag
}

function tmux_from_source() {
    sudo apt -y remove tmux
    rm -rf tmux-2.6*
    wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
    tar xf tmux-2.6.tar.gz
    cd tmux-2.6
    ./configure
    make -j 2
    sudo make install
}

function vim_configuration() {
    if [ ! -d ~/.vim_runtime ]
    then
        git clone --depth=1 https://github.com/jaysh/vimrc.git ~/.vim_runtime
        bash ~/.vim_runtime/install_awesome_vimrc.sh
    fi
}

function tmux_configuration() {
    rm -f ~/.tmux.conf
    ln -s `pwd`/tmux.conf ~/.tmux.conf
    tmux source-file ~/.tmux.conf
}

function fzf_install() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

function main() {
    if [[ $(uname -s) == "Linux" ]]
    then
        vim_from_source
        tmux_from_source
    else
        set +x
        echo "Please ensure you have git and vim/tmux up-to-date."
        echo "Press enter to proceed, or CTRL+C to exit..."
        read
        set -x
    fi
    fzf_install
    vim_configuration
    tmux_configuration
}

main

