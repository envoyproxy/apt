#!/usr/bin/env bash

set -e -o pipefail

APTLY_BIN="$APTLY_BIN"
APTLY_CONF="${APTLY_CONF:-${APTLY_CONF}}"
APTLY=("$APTLY_BIN" -config="${APTLY_CONF}")

publish_root () {
    "${APTLY[@]}" config show \
        | jq -r '.FileSystemPublishEndpoints.public.rootDir'
}

publish_repository () {
    PUBLIC_DIR="$(publish_root)"
    mkdir -p "${PUBLIC_DIR}"
    KEY_URL="${DEPLOY_PRIME_URL}/envoy-maintainer-public.key"
    cat "$MAINTAINER_KEY" > "${PUBLIC_DIR}/envoy-maintainer-public.key"
    echo "<h1>COMING SOON: ${DEPLOY_PRIME_URL}</h1>" > "${PUBLIC_DIR}/index.html"
    echo "<div>Signing key: <a href=\"${KEY_URL}\">${KEY_URL}</div>" >> "${PUBLIC_DIR}/index.html"
}

publish_repository
