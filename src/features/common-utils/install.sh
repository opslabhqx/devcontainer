#!/usr/bin/env bash

set -o errexit -o pipefail

USERNAME="${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
HOME=/home/"${USERNAME:-"${_REMOTE_USER:-"vscode"}"}"
FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Debian / Ubuntu packages
install_debian_packages() {
    export DEBIAN_FRONTEND=noninteractive

    local package_list=""
    if [ "${PACKAGES_ALREADY_INSTALLED}" != "true" ]; then
        package_list="${package_list} \
        apt-transport-https \
        apt-utils \
        bash-completion \
        bzip2 \
        build-essential \
        ca-certificates \
        curl \
        dirmngr \
        git \
        gnupg2 \
        init-system-helpers \
        iproute2 \
        jq \
        less \
        lsb-release \
        lsof \
        make \
        nano \
        net-tools \
        openssh-client \
        procps \
        psmisc \
        rsync \
        strace \
        sudo \
        tree \
        unzip \
        vim-tiny \
        wget \
        xz-utils \
        zip \
        zsh"
    fi

    apt-get update -y || { echo "apt-get update failed"; exit 1; }
    apt-get install -y --no-install-recommends "${package_list}" 2> >( grep -v 'debconf: delaying package configuration, since apt-utils is not installed' >&2 )

    apt-get upgrade -y --no-install-recommends

    apt-get autoremove -y
    apt-get clean -y
    rm -rf /var/lib/apt/lists/*
}

function setup_user_files() {
    if type bash > /dev/null 2>&1; then
        cat "${FEATURE_DIR}/files/.bashrc" >> "${HOME}"/.bashrc
        sudo chown "${USER}":"${USER}" "${HOME}"/.bashrc
        sudo chmod 644 "${HOME}"/.bashrc
        touch "${HOME}"/.bash_history
        sudo chown "${USER}":"${USER}" "${HOME}"/.bash_history
        sudo chmod 600 "${HOME}"/.bash_history
    fi
    
    if type git > /dev/null 2>&1; then
        sudo git config --system --add safe.directory '*'
        cat "${FEATURE_DIR}/files/.netrc" >> "${HOME}"/.netrc
        sudo chown "${USER}":"${USER}" "${HOME}"/.netrc
        sudo chmod 644 "${HOME}"/.netrc
    fi

    if type zsh > /dev/null 2>&1; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${HOME}"/.zsh/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}"/.zsh/zsh-syntax-highlighting
        cat "${FEATURE_DIR}/files/.zshrc" >> "${HOME}"/.zshrc
        sudo chown "${USER}":"${USER}" "${HOME}"/.zshrc
        sudo chmod 644 "${HOME}"/.zshrc
        touch "${HOME}"/.zsh_history
        sudo chown "${USER}":"${USER}" "${HOME}"/.zsh_history
        sudo chmod 600 "${HOME}"/.zsh_history
    fi

    if type ssh > /dev/null 2>&1; then
        cat "${FEATURE_DIR}/files/.config" >> "${HOME}"/.ssh/config
        sudo chown "${USER}":"${USER}" "${HOME}"/.ssh/config
        sudo chmod 644 "${HOME}"/.ssh/config
    fi
}

function main() {
    install_debian_packages
    setup_user_files
}

main
