#!/usr/bin/env bash

export YADM_DIR="$HOME/.config/yadm"
export YADM_SCRIPTS="${YADM_DIR}/scripts"
export YAMD_PACKAGES=${YADM_DIR}/packages
export COMMON_DIR="${YADM_DIR}/scripts/common"
export YADM_TEMPLATES="${YADM_DIR}/bootstrap.d/config_templates"

echo "YADM_DIR: $YADM_DIR"
echo "YADM_SCRIPTS: $YADM_SCRIPTS"
echo "COMMON_DIR: $COMMON_DIR"
echo "YADM_TEMPLATES: $YADM_TEMPLATES"

# Source all files in the common directory except this one
for file in "$COMMON_DIR"/*.sh; do
  # Skip sourcing this file (all.sh) to prevent recursion
  if [ "$(basename "$file")" != "all.sh" ]; then
    source "$file"
  fi
done
