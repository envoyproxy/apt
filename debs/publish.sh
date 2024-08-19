#!/usr/bin/env bash

set -e -o pipefail

APTLY_BIN="$APTLY_BIN"
APTLY_CONF="${APTLY_CONF:-${APTLY_CONF}}"
APTLY=("$APTLY_BIN" -config="${APTLY_CONF}")

DEBS_ROOT="${DEBS_ROOT:-${DEBS_ROOT_DEFAULT}}"

publish_dir () {
    "${APTLY[@]}" config show \
        | jq -r '.FileSystemPublishEndpoints.public.rootDir'
}

create_dirs () {
    PUBLIC_DIR="$(publish_dir)"
    mkdir -p "${PUBLIC_DIR}"
    mkdir -p "${DEBS_ROOT}"
}

unpack_debs () {
    if [[ -s "$DEBS" ]]; then
        tar xf "$DEBS" -C "$DEBS_ROOT"
    fi
}

publish_repository () {
    PUBLIC_DIR="$(publish_dir)"
    KEY_URL="${DEPLOY_PRIME_URL}/envoy-maintainer-public.key"
    cat "$MAINTAINER_KEY" > "${PUBLIC_DIR}/envoy-maintainer-public.key"
    echo "<h1>COMING SOON: ${DEPLOY_PRIME_URL}</h1>" > "${PUBLIC_DIR}/index.html"
    echo "<div>Signing key: <a href=\"${KEY_URL}\">${KEY_URL}</div>" >> "${PUBLIC_DIR}/index.html"
}

publish () {
    create_dirs
    unpack_debs
    publish_repository
}

publish
