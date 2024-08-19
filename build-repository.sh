#!/usr/bin/env bash

set -e -o pipefail

BOLD="\e[1m"
UNDERLINE="\e[4m"
NORMAL="\e[0m"


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

import_public_key
bazel run --config=ci //debs:publish
