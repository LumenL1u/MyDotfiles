#!/usr/bin/env bash

if [ -n "$BASH_SOURCE" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "$ZSH_VERSION" ]; then
  # NOTE: 使用 eval 隐藏 zsh 专属语法，避免 shfmt 静态解析报错
  eval 'SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"'
else
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi
cd "$SCRIPT_DIR" || exit

git pull origin main 2>/dev/null || true

doIt() {
  # 1. 安装依赖（字体、CLI、插件等）
  chmod +x ./pluginstall.sh && ./pluginstall.sh

  # 2. 用 GNU Stow 创建符号链接
  if ! command -v stow &>/dev/null; then
    echo "Error: GNU stow is not installed. Please install it first."
    echo "Install via: brew install stow (macOS) / apt install stow (Linux) / dnf install stow / pacman -S stow"
    echo "Then run: stow --adopt -v -t ~ ."
    return 1
  fi
  
  stow --adopt -v -t "$HOME" .
  echo "提示：若 git status 显示仓库文件被改动，可执行 'cd ~/dotfiles && git checkout -- .' 恢复。"
  echo "✅ Done! Please restart your terminal or run 'exec zsh' to enjoy your new environment."
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
  doIt
else
  ask() {
    if [ -n "$ZSH_VERSION" ]; then
      read -k 1 "REPLY?$1"
    else
      read -p "$1" -n 1 -r REPLY
    fi
    echo ""
  }
  ask "This will create soft link in your home directory. Do you want continue? (y/n) "
  if [[ $REPLY == [Yy] ]]; then doIt; fi
fi
unset -f doIt
