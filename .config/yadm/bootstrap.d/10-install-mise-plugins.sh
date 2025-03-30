#!/usr/bin/env bash

printf "${YELLOW}%s${NC}\n" "Installing mise plugins..."
(cd ~ && mise install --yes)
