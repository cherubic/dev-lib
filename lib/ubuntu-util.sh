#!/usr/bin/env bash

# this is a library of common functions that can be used by other scripts
DLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"

# shellcheck source=/dev/null
source "${DLIB_ROOT}/lib/logging.sh"

util::ubuntu::install_com() {
    (sudo apt-get update -y && sudo apt-get install -y "${1}") || \
    util::log::error_exit "Failed to install ${1}"
}
