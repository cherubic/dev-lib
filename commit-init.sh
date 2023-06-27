#!/bin/bash

set -x

# This script is used to init git repository commit hooks tools and config.
function check_pre_tools() {
    command_name=$1
    if ! command -v $command_name &> /dev/null
    then
        echo "$command_name could not be found"
        exit 1
    fi
}

function check_tools() {
    command_name=$1
    if ! command -v $command_name &> /dev/null
    then
        echo "$command_name could not be found"
        return 1
    else
        echo "$command_name has been installed"
        return 0
    fi
}

function install_husky() {
    pushd .
    echo "install husky by npm"
    if check_tools "husky"; then
        echo "husky has been installed"
    else
        echo "install husky"
        npm install husky --save-dev
        npx husky-init && npm install
        npm pkg set scripts.test="echo \"no test\""
    fi
    popd || return
}

function install_commitlint() {
    pushd .
    echo "install commitlint by npm"
    npm install --save-dev @commitlint/{config-conventional,cli}
    popd || return
}

function install_commitizen() {
    pushd .
    echo "install commitizen by npm"
    ! check_tools commitizen && npm install -g commitizen
    commitizen init cz-conventional-changelog --save-dev --save-exact --force
    popd || return
}

function setup_commithook() {
    pushd .
    echo "setup commit hook"
    npx husky add .husky/commit-msg "npx --no-install commitlint --config .commitlint.config.js --edit \${1}"
    popd || return
}

function main() {
    check_pre_tools "git"
    check_pre_tools "node"

    pushd .
    test ! -f "package.json" && echo "{}" > package.json
    popd || return

    install_husky
    install_commitlint
    install_commitizen

    setup_commithook
}

main "$@"