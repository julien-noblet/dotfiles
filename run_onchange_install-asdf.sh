#!/bin/sh

# install asdf
# if ~/.asdf not exist then install asdf
if [ ! -d ~/.asdf ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
fi

# add asdf to shell
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

asdf plugin add nodejs
asdf plugin add age
asdf plugin add github-cli
asdf plugin add golang
asdf plugin add lazygit
asdf plugin add chezmoi
asdf plugin add neovim