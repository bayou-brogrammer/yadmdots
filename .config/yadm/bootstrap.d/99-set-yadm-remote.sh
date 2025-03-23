#!/usr/bin/env sh

echo "Updating the yadm repo origin URL"
yadm remote set-url origin "https://github.com/bayou-brogrammer/yadmdots.git"
yadm remote set-url --push origin "git@github.com:bayou-brogrammer/yadmdots.git"
