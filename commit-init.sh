#!/bin/bash

# This script is used to init git repository commit hooks tools and config.
function check_pre_tools() {
    command_name=$1
    if ! command -v "$command_name" &> /dev/null
    then
        echo "$command_name could not be found"
        exit 1
    fi
}

function check_tools() {
    command_name=$1
    if ! command -v "$command_name" &> /dev/null
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
    if [ -d .husky ]; then
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
    commitlint_config
    popd || return
}

function commitlint_config() {
    pushd .
    echo "commitlint config"
    if [ ! -f .commitlint.config.js ]; then
        cat <<EOF > .commitlint.config.js
module.exports = {
	parserPreset: 'conventional-changelog-conventionalcommits',
	rules: {
		'body-leading-blank': [1, 'always'],
		'body-max-line-length': [2, 'always', 100],
		'footer-leading-blank': [1, 'always'],
		'footer-max-line-length': [2, 'always', 100],
		'header-max-length': [2, 'always', 100],
		'subject-case': [
			1,
			'never',
			['sentence-case', 'start-case', 'pascal-case', 'upper-case'],
		],
		'subject-empty': [2, 'never'],
		'subject-full-stop': [1, 'never', '.'],
		'type-case': [2, 'always', 'lower-case'],
		'type-empty': [2, 'never'],
		'type-enum': [
			2,
			'always',
			[
				'build',
				'chore',
				'ci',
				'docs',
				'feat',
				'fix',
				'perf',
				'refactor',
				'revert',
				'style',
				'test',
			],
		],
	},
};
EOF
    fi
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
    if ! grep -q "commitlint" .husky/commit-msg; then
        npx husky add .husky/commit-msg "npx --no-install commitlint --config .commitlint.config.js --edit \${1}"
    fi
    popd || return
}

function setup_gitignore() {
    pushd .
    echo "setup gitignore file"
    if grep -q "node_modules" .gitignore; then
        echo "node_modules has been added to .gitignore"
    else
        echo "add node_modules to .gitignore"
        echo "node_modules" >> .gitignore
    fi

    if grep -q ".husky" .gitignore; then
        echo ".husky has been added to .gitignore"
    else
        echo "add .husky to .gitignore"
        echo ".husky" >> .gitignore
    fi

    if grep -q ".commitlint.config.js" .gitignore; then
        echo ".commitlint.config.js has been added to .gitignore"
    else
        echo "add .commitlint.config.js to .gitignore"
        echo ".commitlint.config.js" >> .gitignore
    fi
    
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
    setup_gitignore

    echo "commit init success"
}

main "$@"