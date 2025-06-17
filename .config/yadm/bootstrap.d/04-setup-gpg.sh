#!/bin/sh

echo "Setting up gpg keys..."

brew install gnupg

mkdir -p ~/.local/share/gnupg
mkdir -p ~/.local/share/gnupg/.exported-keyring
yadm decrypt

#yadm decrypt
gpg --import "$HOME/.local/share/gnupg/.exported-keyring"/*.asc
gpg --import-ownertrust "$HOME/.local/share/gnupg/.exported-keyring"/ownertrust.txt
