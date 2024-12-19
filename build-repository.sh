#!/usr/bin/env bash

set -e -o pipefail

BOLD="\e[1m"
UNDERLINE="\e[4m"
NORMAL="\e[0m"

EXCLUDE_FILE=debs/excludes.txt
DEBS_ROOT=/opt/build/cache/repository
SIGNING_KEY_PASSPHRASE="${SIGNING_KEY_PASSPHRASE:-Hackme}"


finally () {
    rm -rf signing.key
    rm -rf debs/signing-token.txt
}

trap finally EXIT

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

generate_private_key () {
    echo -e "$(underline $(bold "Generate snakeoil private key: repository signing"))"
    gpg --batch --pinentry-mode loopback --passphrase "" --gen-key <<EOF
%echo Generating a basic OpenPGP key
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Name-Real: Envoy CI
Name-Email: envoy-ci@for.testing.only
Expire-Date: 0
Passphrase: ${SIGNING_KEY_PASSPHRASE}
%commit
%echo done
EOF
    gpg --export -a "Envoy CI" > site/signing.key.txt
}

import_private_key () {
    echo -e "$(underline $(bold "Import maintainers private signing key: repository signing"))"
    echo "${SIGNING_KEY_0}${SIGNING_KEY_1}${SIGNING_KEY_2}${SIGNING_KEY_3}" \
        | base64 -d \
        | gpg --batch --pinentry-mode loopback --import
}

create_excludes () {
    if [[ -e "${DEBS_ROOT}" ]]; then
        ls "${DEBS_ROOT}" \
            | (grep -E '^v[0-9]+\.[0-9]+\.[0-9]+' || echo '') \
            | sort -u > "$EXCLUDE_FILE"
    else
        touch "$EXCLUDE_FILE"
    fi
}

configure_gpg () {
    import_public_key
    echo "${SIGNING_KEY_PASSPHRASE}" > debs/signing-token.txt
    if [[ "$CONTEXT" == "deploy-preview" ]]; then
        generate_private_key
    else
        import_private_key
    fi
}

main () {
    local bazel_args=(--config=publish-ci)
    create_excludes
    configure_gpg
    if [[ "$CONTEXT" == "deploy-preview" ]]; then
        echo "$DEPLOY_PRIME_URL" > site/url.txt
        bazel_args+=(
            -s
            --//site:url=//site:url.txt
            --//site:signing-key=//site:signing.key.txt)
    else
        bazel_args+=(--//:production=//:true)
    fi
    bazel run \
          "${bazel_args[@]}" \
          //tools/tarball:unpack \
          /opt/build/repo/html
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
