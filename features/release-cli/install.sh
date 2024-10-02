#!/usr/bin/env bash

set -o errexit -o pipefail

RELEASECLI_VERSION=v0.18.0

installed_packages=()

function clean_build() {
    echo "Cleaning up..."
    if [[ ${#installed_packages[@]} -gt 0 ]]; then
        echo "Removing installed packages: ${installed_packages[*]}"
        $(which sudo) apt-get remove -y --purge "${installed_packages[@]}"
        $(which sudo) apt-get -y autoremove
    fi
}

function check() {
    ARCH="$(uname -m)"
    case ${ARCH} in
        x86_64) ARCH="amd64";;
        aarch64 | armv8*) ARCH="arm64";;
        *) echo "(!) Architecture ${ARCH} unsupported"; exit 1 ;;
    esac
}

function define_apt() {
    local commands="$@"
    echo "Updating package list..."
    $(which sudo) apt-get update
    for cmd in $commands; do
        if command -v "$cmd" >/dev/null 2>&1; then
            echo "$cmd is already installed."
        else
            echo "$cmd is not installed. Installing..."
            export DEBIAN_FRONTEND=noninteractive
            $(which sudo) apt-get install -y --no-install-recommends "$cmd" || { echo "Error: Failed to install $cmd"; exit 1; }
            installed_packages+=("$cmd")
        fi
    done
}

function install_release_cli() {
    check
    if ! command -v release-cli >/dev/null 2>&1; then
        echo "release-cli is not installed. Downloading and installing..."
        $(which sudo) curl --location --output /usr/local/bin/release-cli "https://gitlab.com/gitlab-org/release-cli/-/releases/${RELEASECLI_VERSION}/downloads/bin/release-cli-linux-${ARCH}"
        $(which sudo) chmod +x /usr/local/bin/release-cli
        echo "release-cli installed successfully."
    else
        echo "release-cli is already installed."
    fi
}

function check_gitlab_release() {
    trap '[[ $? -ne 0 ]] && clean_build' EXIT
    echo "Checking dependencies..."
    define_apt bash curl ca-certificates jq
    install_release_cli
    release-cli --version || { echo "Error: Failed to initialize release-cli"; exit 1; }
}

function main() {
    check_gitlab_release
}

main
