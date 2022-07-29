#!/bin/bash
# vi: et sts=4 sw=4 ts=4

# Build a release tarball for apache-css
#
# Copyright (C) 2022 Dan Church.
# License GPLv3: GNU GPL version 3.0 (https://www.gnu.org/licenses/gpl-3.0.html)
# with Commons Clause 1.0 (https://commonsclause.com/).
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.
# You may NOT use this software for commercial purposes.

shopt -s dotglob inherit_errexit
set -e

USAGE() {
    printf 'Usage: %s [VERSION]\n' \
        "${0##*/}"
}

check_required_binaries() {
    local BIN MISSING=()
    for BIN; do
        if ! type -t "$BIN" &>/dev/null; then
            MISSING+=("$BIN")
        fi
    done
    if [[ ${#MISSING[@]} -gt 0 ]]; then
        printf 'Error: You are missing required programs:\n' >&2
        for BIN in "${MISSING[@]}"; do
            printf -- '- %s\n' "$BIN" >&2
        done
        exit 2
    fi
}

check_required_binaries \
    mkdir \
    realpath \
    tar

WORKDIR=${0%/*}
BASEDIR=$(realpath -- "$WORKDIR/..")
VERSION_FILE=$BASEDIR/VERSION
RELEASESDIR=$BASEDIR/releases

PROJECT=apache-autoindex-css
VERSION=$1
if [[ -z $VERSION && -f $VERSION_FILE ]]; then
    VERSION=$(<"$VERSION_FILE")
fi
if [[ -z $VERSION ]]; then
    USAGE >&2
    exit 1
fi
TAR=$RELEASESDIR/$PROJECT-$VERSION.tar.xz

cd "$BASEDIR"

INCLUDE=(
    *.css
    .htaccess
    LICENSE*
    README*
    src/*
    VERSION
)

printf 'Creating "%s"\n' \
    "$TAR"

mkdir -p -- "$RELEASESDIR"
tar -cJ \
    -f "$TAR" \
    --dereference \
    -- \
    "${INCLUDE[@]}"
