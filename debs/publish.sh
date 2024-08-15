#!/usr/bin/env bash

set -e -o pipefail


APTLY_BIN="$APTLY_BIN"
APTLY_CONF="${APTLY_CONF:-${APTLY_CONF}}"
APTLY=("$APTLY_BIN" -config="${APTLY_CONF}")

DEBS_ROOT="${DEBS_ROOT:-${DEBS_ROOT_DEFAULT}}"
REPOS=(focal jammy bullseye bookworm)
SIGNING_KEY="${SIGNING_KEY:-}"
SIGNING_TOKEN="${SIGNING_TOKEN:-${SIGNING_TOKEN}}"

if [[ -z "$SIGNING_KEY" ]]; then
    echo "SIGNING_KEY must be set and exist as a GPG key" >&2
    exit 1
fi


_aptly () {
    "${APTLY[@]}" -- "${@}"
}

uid_generate() {
    local length=${1:-7}
    < /dev/urandom tr -dc 'A-Za-z0-9' | head -c "${length}"
    echo
}

publish_dir () {
    _aptly config show \
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

create_repos () {
    existing_repos=$(_aptly repo list -json | jq -r '.[] | .Name')

    for repo in "${REPOS[@]}"; do
        if ! echo "$existing_repos" | tr ' ' '\n' | grep -q "^${repo}$"; then
            _aptly repo create "$repo"
        fi
    done
}

list_current_changes () {
    for repo in "${REPOS[@]}"; do
        while read -r package; do
            echo "${package}.${repo}.changes"
        done < <(_aptly repo show -with-packages -json "${repo}"  | jq -r '.Packages[]')
    done
}

include_debs () {
    declare -A imported
    while read -r package; do
        imported["$package"]=1
    done < <(list_current_changes)
    while read -r file; do
        filename="$(basename "$file")"
        if [[ "${imported[$filename]}" ]]; then
            continue
        fi
        _aptly repo include -no-remove-files "$file"
    done < <(find "${DEBS_ROOT}" -name "*.changes")
}

publish_repository () {
    local repo uid skip snapshot current result key
    key=$(gpg --list-secret-keys --keyid-format LONG "$SIGNING_KEY" \
              | grep 'sec' \
              | awk '{print $2}' \
              | cut -d'/' -f2)
    if [[ -e "$SIGNING_TOKEN" ]]; then
        SIGNING_KEY_PASSPHRASE="$(cat "$SIGNING_TOKEN")"
    fi
    for repo in "${REPOS[@]}"; do
        uid=$(uid_generate)
        skip=
        snapshot="${repo}-${uid}"
        _aptly snapshot create "$snapshot" from repo "$repo"
        current=$(_aptly publish list -json \
            | jq -r --arg dist "$repo" \
                 '.[] | select(.Distribution == $dist) | .Sources[] | select(.Component == "main") | .Name')
        if [[ -n "$current" ]]; then
            result=$(_aptly snapshot diff "$current" "${snapshot}")
            if [[ "$result" == "Snapshots are identical." ]]; then
                skip=1
            else
                _aptly publish drop "${repo}" "filesystem:public:"
            fi
        fi
        if [[ -z "$skip" ]]; then
            _aptly publish snapshot \
                   -batch \
                   -passphrase "${SIGNING_KEY_PASSPHRASE}" \
                   -gpg-key="${key}" \
                   -distribution "${repo}" \
                   "${snapshot}" \
                   "filesystem:public:"
        fi
    done
}

main () {
    create_dirs
    create_repos
    unpack_debs
    include_debs
    publish_repository
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
