#!/usr/bin/env bash

# this is a library of common functions that can be used by other scripts
DLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"

# shellcheck source=/dev/null
source "${DLIB_ROOT}/lib/logging.sh"

util::darwin::install_com() {
    brew install "${1}" || util::log::error_exit "Failed to install ${1}"    
}

util:darwin:install_brew() {
    util::log::info "Installing brew"
    
    xcode-select --install || util::log::error_exit "Failed to install xcode-select"

    # export HOMEBREW_BREW_GIT_REMOTE="..."  # put your Git mirror of Homebrew/brew here
    # export HOMEBREW_CORE_GIT_REMOTE="..."  # put your Git mirror of Homebrew/homebrew-core here
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" || util::log::error_exit "Failed to install brew"
}