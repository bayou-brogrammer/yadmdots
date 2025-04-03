#!/bin/bash

umask 0077 # -rwx------
EXPORT_PATH="$GNUPGHOME/.exported-keyring"

if [ -d "$EXPORT_PATH" ]; then
  chmod 0700 "$EXPORT_PATH"
else
  mkdir -m 0700 -p "$EXPORT_PATH"
fi

if [ ! -d "$EXPORT_PATH" ]; then
  echo "Unable to create dir $EXPORT_PATH"
  echo "Aborting"
  exit 1
fi

echo "Exporting private key to $EXPORT_PATH"
gpg -a --export-secret-key -o "$EXPORT_PATH/private-key.asc"

echo "Exporting public keyring to $EXPORT_PATH"
for key in $(gpg -k --with-colons | grep pub -A 1 | grep fpr | cut -d: -f10); do
  echo "  Key: $key"
  gpg -a --export "$key" >> "$EXPORT_PATH/${key}.asc"
done

echo "Exporting ownertrust to $EXPORT_PATH"
gpg --export-ownertrust > "$EXPORT_PATH/ownertrust.txt"
