# tmux

可以使用 [`init.sh`](init.sh) 来初始化 tmux 配置，目前支持 `ubuntu` 和 `macos`。

## 主要用途

- 避免终端断开后程序中断
- 不同客户端都可以看到tmux中的内容
- 多窗口管理

## 配置

详细请看配置文件注释 [tmux.conf](tmux.conf)。

## 插件

- tmux-plugins/tpm -- tmux插件管理器
- tmux-plugins/tmux-sensible -- 默认常用的配置
- tmux-plugins/tmux-logging -- 记录tmux的操作
- tmux-plugins/tmux-resurrect -- 保存tmux的状态
- tmux-plugins/tmux-continuum -- 自动保存tmux的状态
- tmux-plugins/tmux-yank -- 复制到系统剪贴板
- dracula/tmux -- dracula主题

## 命令以及快捷键速查表

> 注意事项：
> `prefix` 是tmux的默认前缀，一般是 `Ctrl + b`，我使用的是 `Ctrl+a`。
> `:` 是处于tmux命令模式，输入命令后按回车执行。


| 简短命令 | 命令 | 说明 |
| --- | --- | --- |
| `tmux` | - | 启动tmux |
| `tmux new` | `tmux new -s <session-name>` | 创建一个新的会话 |
| `tmux ls` | `tmux list-session` | 列出所有会话 |
| - | `tmux attach -t <session-name>` | 连接到一个会话 |
| - | `tmux kill-session -t <session-name>` | 关闭一个会话 |
| - | `:kill-server` | 关闭tmux服务 |
| - | `:set -g mouse on` | 开启鼠标支持 |

| 快捷键 | 命令 | 说明 |
| --- | --- | --- |
| `prefix d` | - | 分离tmux |
| `prefix ?` | - | 显示所有快捷键 |
| `prefix c` | - | 创建一个新窗口 |
| `prefix n` | - | 切换到下一个窗口 |
| `prefix p` | - | 切换到上一个窗口 |
| `prefix l` | - | 切换到最后一个窗口，即当前窗口的上一个窗口 |
| `prefix 0-9` | - | 切换到指定窗口 |
| `prefix %` | - | 水平分割窗口 |
| `prefix "` | - | 垂直分割窗口 |
| `prefix x` | - | 关闭当前窗口 |
| `prefix q 0-9` | - | 显示窗格编号后，按对应的数字切换到对应的窗格 |
| `prefix s` | - | 树形展开会话，可选择一个会话 |
| `prefix w` | - | 树形展开会话以及窗格，可选择一个窗格 |

## 参考

- [tmux wiki](https://github.com/tmux/tmux/wiki)
