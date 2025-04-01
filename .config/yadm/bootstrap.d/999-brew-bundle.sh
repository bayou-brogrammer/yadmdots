#!/usr/bin/env bash

echo "Installing Homebrew packages..."
brew bundle --cleanup --upgrade --file ~/.Brewfile
