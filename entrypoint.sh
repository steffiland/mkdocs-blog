#!/bin/sh
set -e

echo "[entrypoint] running as UID $(id -u)"

# Only run chown as root
if [ "$(id -u)" = "0" ]; then
    echo "[entrypoint] running chown for UID=${UID} GID=${GID}"
    chown -R "${UID}:${GID}" /docs /docs/docs /docs/macros || true
    # Use su-exec if available, otherwise fallback to su (alpine-sh compatible)
    if command -v su-exec >/dev/null 2>&1; then
        exec su-exec "$UID:$GID" "$0" "$@"
    else
        exec su -s /bin/sh -c "$0 $*"
    fi
    exit
fi

echo "[entrypoint] running as user"
exec "$@"
