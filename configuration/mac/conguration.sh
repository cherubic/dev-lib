#!/bin/zsh

# 设置代理
function set_proxy() {
    echo "请输入代理地址：" proxy_host
    echo "请输入代理端口：" proxy_port
    echo "请输入代理用户名：" proxy_username
    echo "请输入代理密码：" proxy_password
    echo "请输入代理协议：" proxy_protocol
    echo "正在清理代理..."
    unset ALL_PROXY
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    unset socks_proxy
    unset SOCKS_PROXY
    echo "代理清理完成"
    echo "正在设置代理..."
    export ALL_PROXY=$proxy_protocol://$proxy_username:$proxy_password@$proxy_host:$proxy_port
    export http_proxy=$ALL_PROXY
    export HTTP_PROXY=$ALL_PROXY
    export https_proxy=$ALL_PROXY
    export HTTPS_PROXY=$ALL_PROXY
    export socks_proxy=$ALL_PROXY
    export SOCKS_PROXY=$ALL_PROXY
    echo "代理设置成功！"

    # 测试代理
    echo "正在测试代理..."
    curl -I https://www.google.com
    if [ $? -eq 0 ]; then
        echo "代理测试成功！"
    else
        echo "代理测试失败！"
    fi

    # 设置 shell 代理快捷命令
    echo "正在设置代理快捷命令..."
    echo "### code configuration -- proxy setup ###" >> ~/.zshrc.alias
    echo "alias proxy_on=\"export ALL_PROXY=$ALL_PROXY\n HTTP_PROXY=$ALL_PROXY\n https_proxy=$ALL_PROXY\n HTTPS_PROXY=$ALL_PROXY\n socks_proxy=$ALL_PROXY\n SOCKS_PROXY=$ALL_PROXY\"" >> ~/.zshrc.alias
    echo "alias proxy_off=\"unset ALL_PROXY\n unset HTTP_PROXY\n unset https_proxy\n unset HTTPS_PROXY\n unset socks_proxy\n unset SOCKS_PROXY\"" >> ~/.zshrc.alias
    echo "source ~/.zshrc.alias" >> ~/.zshrc
    echo "### code configuration -- proxy setup ###" >> ~/.zshrc.alias
    echo "代理快捷命令设置完成！"
    echo "请使用 proxy_on 开启代理，proxy_off 关闭代理"
}

# 安装Homebrew
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装oh-my-zsh
/bin/zsh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装oh-my-zsh插件
# zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k



# 安装主流程
function main() {
    # 提示设置代理
    echo "是否设置代理？（提示：没有代理的情况下某些步骤无法完成）"
    echo "y. 是"
    echo "n. 否"
    read -p "请输入(y/n):" proxy
    if [ $proxy == "y" ]; then
        set_proxy
    fi

    # 
}

main