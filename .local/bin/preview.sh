#!/usr/bin/env bash

# preview file contents

[ -z "$1" ] && exit

# directories
[ -d "$1" ] && tree -C "$1" && exit

# files
file=$(readlink -f "$1")
shift
dir=$(dirname "$file")
cd "$dir" || exit

MIME=$(file --dereference --mime "$file")
[[ "$MIME" =~ binary ]] && {
  echo "$MIME"
  exit
}

case "$file" in
*\.pdf) pdftotext "$file" ;;
*) bat -p --color=always "$file" ;;
esac
