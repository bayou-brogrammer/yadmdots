#!/usr/bin/env bash

printf "${YELLOW}%s${NC}\n" "Installing mise plugins..."
(cd ~ && mise install --yes)

if [[ $(uname -s) != 'Darwin' ]]; then
  if [[ ! -f ${HOME}/.fzf.zsh ]]; then
    printf "${YELLOW}%s${NC}\n" "Installing FZF scripts"
    "$(mise where fzf)/install" --no-update-rc --completion --key-bindings
  fi
fi
