#!/usr/bin/env bash

# this is a library of common functions that can be used by other scripts
DLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${DLIB_ROOT}/lib/logging.sh"

util::common::os_detect() {
    UNAME=$(command -v uname)

    case $("${UNAME}" | tr '[:upper:]' '[:lower:]') in
    linux*)
        if grep -q "Ubuntu" /etc/os-release 2>/dev/null; then
            echo 'ubuntu'
        elif grep -q "CentOS" /etc/os-release 2>/dev/null; then
            echo 'centos'
        else
            echo 'linux'
        fi
        ;;
    darwin*)
        echo 'darwin'
        ;;
    msys* | cygwin* | mingw*)
        echo 'windows'
        ;;
    nt | win*)
        echo 'windows'
        ;;
    *)
        echo 'unknown'
        ;;
    esac
}

util::common::command_exists() {
    command -v "${1}" > /dev/null 2>&1
}

util::common::install_com() {
    local os
    os="${1}"
    com_name="${2}"

    case "${os}" in
    "darwin")
        echo "util::darwin::install_com \"${com_name}\""
        ;;
    "ubuntu")
        echo "util::ubuntu::install_com \"${com_name}\""
        ;;
    *)
        util::log::error_exit "Unsupported OS: ${os}"
        ;;
    esac
}