#!/bin/sh

echo "Setting up gpg keys..."

#yadm decrypt
gpg --import "$HOME/.local/share/gnupg/.exported-keyring"/*.asc
gpg --import-ownertrust "$HOME/.local/share/gnupg/.exported-keyring"/ownertrust.txt
