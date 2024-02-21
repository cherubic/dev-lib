# dev lib

个人计算机编码规范，工具，脚本，配置等。

## 工具

- [tmux](./tools/tmux/README.md): 终端复用工具，提升开发以及运维效率。
- [oh my zsh](./tools/oh-my-zsh/README.md): Unix Shell和命令解释器，美观，强大。
- [vim](./tools/vim/README.md): 代码编辑器，适用于服务器开发。
- [visual studio code](./tools/visual-studio-code/README.md): 代码编辑器，更加便捷，适用于所有语言开发。

### visual studio code

代码编辑器，[官网](https://code.visualstudio.com/)
[文档](./configuration/README.md#visual-studio-code)

### vim

代码编辑器，[官网](https://www.vim.org/)
[文档](./configuration/README.md#vim)

### zsh

Unix Shell和命令解释器，[官网](https://ohmyz.sh/)

### bash

Unix Shell和命令解释器，[官网](https://www.gnu.org/software/bash/)

## 配置

### Mac

### Linux

### Windows

## 规范

### commit

1. 相关规范
    - [约定式提交规范](https://www.conventionalcommits.org/zh-hans/v1.0.0/#%e7%ba%a6%e5%ae%9a%e5%bc%8f%e6%8f%90%e4%ba%a4%e8%a7%84%e8%8c%83)
    - [语义版本规范2.0.0](https://semver.org/lang/zh-CN/)
    - [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt)

2. 相关工具
    - git hook: [website](https://git-scm.com/book/zh/v2/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-Git-%E9%92%A9%E5%AD%90)；git操作的hook，分别有 `pre-commit`(提交前), `prepare-commit-msg`  (编辑提交信息前), `commit-msg`(编辑提交信息后), `pre-receive`(推送接收到信息前), `update`(更新引用前，一般用于服务端触发), `pre-push`(推送前), `post-update`(引用更新后)
    - commitlint: [website](https://commitlint.js.org/#/), [github](https://github.com/conventional-changelog/commitlint)；校验提交消息的工具
    - Commitizen: [website](http://commitizen.github.io/cz-cli/), [github](http://commitizen.github.io/cz-cli/)；提交代码时强制执行规范化的提交消息格式
    - cz-customizable(可选): [github](https://github.com/leoforfree/cz-customizable)；提交代码时强制执行规范化的提交消息格式
    - husky: [website](https://typicode.github.io/husky/#/), [github](https://github.com/typicode/husky)；git hook管理工具
    - Commitlint Conventional Commit (JetBrains IDE Plugin) [website](https://plugins.jetbrains.com/plugin/13389-conventional-commit)
    - Conventional Commit (JetBrains IDE Plugin) [website](https://plugins.jetbrains.com/plugin/14046-commitlint-conventional-commit)

3. 相关脚本
    - commit-init.sh (Linux/Mac脚本)
    - commit-init.ps1 (Windows脚本)

4. 如何使用
    首先必须预先安装git，node命令以及相关工具

    - Linux/Mac
        1. `sudo wget -O /usr/local/bin/commit-init "https://gist.githubusercontent.com/cherubic/ddddcc14e79d83c8c150b1f42b282599/raw/4f8483e2d00291a01ad9d0d98a657121c623a846/commit-init.sh" && sudo chmod +x /usr/local/bin/commit-init`
        2. 后续在项目根目录下执行 `commit-init` 即可
