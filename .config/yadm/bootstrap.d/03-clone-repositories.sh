#!/usr/bin/env bash

# Clone ZSH repo
if [ ! -d "$HOME/.config/zsh" ]; then
  git clone https://github.com/${GITHUB_USER}/zsh.git "$HOME/.config/zsh"

  echo "Updating the zsh repo origin URL"
  git remote set-url origin "https://github.com/${GITHUB_USER}/zsh.git"
  git remote set-url --push origin "git@github.com:${GITHUB_USER}/zsh.git"
fi

# Clone neovim config
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/${GITHUB_USER}/nvim.git "$HOME/.config/nvim"

  echo "Updating the neovim repo origin URL"
  git remote set-url origin "https://github.com/${GITHUB_USER}/nvim.git"
  git remote set-url --push origin "git@github.com:${GITHUB_USER}/nvim.git"
fi
