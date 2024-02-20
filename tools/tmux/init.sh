#!/bin/bash

DLIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &> /dev/null && pwd)"

# shellcheck source=/dev/null
source "${DLIB_ROOT}/lib/util.sh"

main() {
    local os
    os=$(util::common::os_detect)

    util::log::info "os is ${os}"

    util::log::info "installing tmux"

    # install tmux
    case "${os}" in
    "darwin")
        # shellcheck source=/dev/null
        source "${DLIB_ROOT}/lib/${os}-util.sh"

        util::common::command_exists "brew" || \
        util::darwin::install_brew || \
        util::log::error_exit "Failed to install brew"

        ;;
    "ubuntu")
        # shellcheck source=/dev/null
        source "${DLIB_ROOT}/lib/${os}-util.sh"
        ;;
    *)
        util::log::error_exit "Unsupported OS: ${os}"
        ;;
    esac

    util::common::command_exists "tmux" || \
    eval "$(util::common::install_com "${os}" "tmux")" || \
    util::log::error_exit "Failed to install tmux"

    util::log::info "tmux is installed"

    # install tmux plugin manager
    util::log::info "installing tmux plugin manager"

    util::common::command_exists "git" || \
    eval "$(util::common::install_com "${os}" "git")" || \
    util::log::error_exit "Failed to install git"

    [ -d "${HOME}/.tmux/plugins/tpm" ] || \
    git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm" || \
    "${HOME}"/.tmux/plugins/tpm/bin/install_plugins
    util::log::error_exit "Failed to install tmux plugin manager"

    util::log::info "tmux plugin manager is installed"

    local tmux_conf
    tmux_conf="${HOME}/.tmux.conf"
    datetime=$(date "+%Y%m%d%H%M%S")
    [ -f "${tmux_conf}" ] && mv "${tmux_conf}" "${tmux_conf}.${datetime}.bak"

    cp -f "${DLIB_ROOT}/tools/tmux/tmux.conf" "${tmux_conf}"

    util::log::info "tmux configuration is installed"

    util::log::info "tmux is installed successfully"
}