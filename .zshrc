# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)
# before source $ZSH/oh-my-zsh.sh
function zvm_config() {
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
    ZVM_ESCAPE_KEYTIMEOUT=0.1
}
DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh

# source extra files: 跨平台共享配置
for file in ~/.{exports,aliases,functions,extra,path,exports.local}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# 平台专属别名
if [[ "$OSTYPE" == darwin* && -r ~/.aliases.macos ]]; then
  source ~/.aliases.macos
elif [[ "$OSTYPE" == linux* && -r ~/.aliases.linux ]]; then
  source ~/.aliases.linux
fi

# Proxy switch（可通过环境变量覆盖，避免把本机代理地址写死在仓库里）
export PROXY_ADDR="${PROXY_ADDR:-http://127.0.0.1:33211}"
function proxy_on() {
    export http_proxy=$PROXY_ADDR
    export https_proxy=$PROXY_ADDR
    export all_proxy=$PROXY_ADDR
    export no_proxy="localhost,127.0.0.1,::1,192.168.*"
    echo "Terminal proxy enabled: $PROXY_ADDR"
}
function proxy_off() {
    unset http_proxy https_proxy all_proxy no_proxy
    echo "Terminal proxy disabled"
}

# pyenv：仅在已安装时初始化
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    eval "$(pyenv init - zsh)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
