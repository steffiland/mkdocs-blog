#!/bin/bash
set -e

# Nur als root ausführen
if [ "$(id -u)" = "0" ]; then
    chown -R ${UID}:${GID} /docs /docs/docs /docs/macros || true
    exec su-exec ${UID}:${GID} "$0" "$@"  # Skript als Nicht-Root erneut ausführen
    exit
fi

# Ab hier läuft das Skript als mkdocs User
exec "$@"
