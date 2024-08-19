#!/usr/bin/env bash

set -e -o pipefail

BOLD="\e[1m"
UNDERLINE="\e[4m"
NORMAL="\e[0m"

EXCLUDE_FILE=debs/custom-excludes.txt
DEBS_ROOT=/opt/build/cache/repository

bold () {
    echo -n "${BOLD}${*}${NORMAL}"
}

underline () {
    echo -n "${UNDERLINE}${*}${NORMAL}"
}

import_public_key () {
    touch ~/.gnupg/trustedkeys.gpg
    echo -e "$(underline $(bold "Import maintainers public key: checksum verification"))"
    gpg --import envoy-maintainers-public.key
    echo -e "$(underline $(bold "Import maintainers public key as trusted key: deb verification"))"
    gpg --no-default-keyring --keyring trustedkeys.gpg --import envoy-maintainers-public.key
}

create_excludes () {
    # Prevent re-downloading cached files
    if [[ -e "${DEBS_ROOT}" ]]; then
        ls "${DEBS_ROOT}" | (grep -E '^v[0-9]+\.[0-9]+\.[0-9]+' || echo '') | sort -u > "$EXCLUDE_FILE"
    else
        touch "$EXCLUDE_FILE"
    fi
}

import_public_key
create_excludes
bazel run --config=debs-ci //debs:publish
