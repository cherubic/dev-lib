#!/usr/bin/env pwsh

# This script is used to init git repository commit hooks tools and config.
function check_pre_tools {
    param([string]$command_name)
    if ($null -eq (Get-Command $command_name -ErrorAction SilentlyContinue))
    {
        Write-Host "$command_name could not be found"
        exit 1
    }
}

function check_tools {
    param([string]$command_name)
    if ($null -eq (Get-Command $command_name -ErrorAction SilentlyContinue))
    {
        Write-Host "$command_name could not be found"
        return 1
    }
    else
    {
        Write-Host "$command_name has been installed"
        return 0
    }
}

function install_husky {
    Write-Host "install husky by npm"
    if (Test-Path -Path .husky) {
        Write-Host "husky has been installed"
    } 
    else {
        Write-Host "install husky"
        npm install husky --save-dev
        npx husky-init
        npm pkg set scripts.test='echo "no test"'
        npm install
    }
}

function install_commitlint {
    Write-Host "install commitlint by npm"
    npm install --save-dev @commitlint/config-conventional @commitlint/cli
    commitlint_config
}

function commitlint_config {
    Write-Host "commitlint config"
    if (!(Test-Path -Path .commitlint.config.js)) {
        @"
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
"@ | Out-File -FilePath .commitlint.config.js
    }
}

function install_commitizen {
    Write-Host "install commitizen by npm"
    if (!(check_tools commitizen)) {
        npm install -g commitizen
    }
    commitizen init cz-conventional-changelog --save-dev --save-exact --force
}

function setup_commithook {
    Write-Host "setup commit hook"
    if (!(Test-Path .husky/commit-msg) || 
    (Test-Path .husky/commit-msg && !(Select-String -Path .husky/commit-msg -Pattern "commitlint" -Quiet))) {
        npx husky add .husky/commit-msg "npx --no-install commitlint --config .commitlint.config.js --edit \${1}"
    }
}

function setup_gitignore {
    Write-Host "setup gitignore file"
    if (Test-Path .gitignore) {
        Write-Host ".gitignore has been created"
    } 
    else {
        Write-Host "create .gitignore file"
        New-Item -Path . -Name .gitignore -ItemType "file"
    }

    if ((Get-Content .gitignore | Select-String -Pattern "node_modules" -Quiet)) {
        Write-Host "node_modules has been added to .gitignore"
    } 
    else {
        Write-Host "add node_modules to .gitignore"
        Add-Content -Path .gitignore -Value "node_modules"
    }

    if ((Get-Content .gitignore | Select-String -Pattern ".husky" -Quiet)) {
        Write-Host ".husky has been added to .gitignore"
    } 
    else {
        Write-Host "add .husky to .gitignore"
        Add-Content -Path .gitignore -Value ".husky"
    }

    if ((Get-Content .gitignore | Select-String -Pattern ".commitlint.config.js" -Quiet)) {
        Write-Host ".commitlint.config.js has been added to .gitignore"
    } 
    else {
        Write-Host "add .commitlint.config.js to .gitignore"
        Add-Content -Path .gitignore -Value ".commitlint.config.js"
    }
}

function main {
    check_pre_tools "git"
    check_pre_tools "node"

    if (!(Test-Path -Path "package.json")) {
        "{}" | Out-File -FilePath package.json
    }

    install_husky
    install_commitlint
    install_commitizen

    setup_commithook
    setup_gitignore

    Write-Host "commit init success"
}

main
