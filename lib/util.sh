#!/usr/bin/env bash

# this is a library of common functions that can be used by other scripts
DLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=/dev/null
source "${DLIB_ROOT}/lib/logging.sh"

util::common::os_detect() {
    UNAME=$(command -v uname)

    case $("${UNAME}" | tr '[:upper:]' '[:lower:]') in
    linux*)
        echo 'linux'
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

