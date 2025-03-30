#!/bin/sh

# Because Git submodule commands cannot operate without a work tree, they must
# be run from within $HOME (assuming this is the root of your dotfiles)
cd "$HOME"

echo "Init submodules"
yadm submodule update --recursive --init

echo "Updating the zdotdir repo origin URL"
cd ~/.config/zsh
git remote set-url origin "git@github.com:bayou-brogrammer/zdotdir.git"

echo "Updating the nvim repo origin URL"
cd ~/.config/nvim
git remote set-url origin "git@github.com:bayou-brogrammer/nvim.git"

echo "Updating the astronvim repo origin URL"
cd ~/.config/astro-nvim/
git remote set-url origin "git@github.com:bayou-brogrammer/nvim.git"
