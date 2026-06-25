# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# source extra files, suchu as .path, .aliases, .functions, .extra.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Proxy switch
export PROXY_ADDR="http://127.0.0.1:7890"
function proxy_on() {
    export http_proxy=$PROXY_ADDR
    export https_proxy=$PROXY_ADDR
    export all_proxy=$PROXY_ADDR
    echo "🌐 终端代理已开启: $PROXY_ADDR"
    curl -I https://www.google.com --connect-timeout 5 2>&1 | grep -i "HTTP/" || echo "⚠️ 无法连接到 Google，请检查代理软件是否启动！"
}
function proxy_off() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "❌ 终端代理已关闭"
}

# Reduce startup time
DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
