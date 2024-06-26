#!/usr/bin/env bash

set -euo pipefail

echo >&2 "build-image.bash: tagging apheleia-formatters:${TAG:-latest}"

if [[ -n "${FORMATTERS:-}" ]]; then
    echo "build-image.bash: will install these formatters: ${FORMATTERS}"
else
    echo "build-image.bash: will install all formatters by default"
fi

cd "$(dirname "$0")"

docker=(docker)
if [[ "$OSTYPE" != darwin* ]] && [[ "$EUID" != 0 ]]; then
    docker=(sudo -E "${docker[@]}")
fi

exec "${docker[@]}" build .                    \
     -t "apheleia-formatters:${TAG:-latest}"   \
     --build-arg "FORMATTERS=${FORMATTERS:-}"
