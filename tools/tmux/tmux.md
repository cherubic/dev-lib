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
