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

git pull origin main

doIt() {
  chmod +x ./pluginstall.sh && ./pluginstall.sh
  if type stow &>/dev/null; then
    stow --adopt -v -t "$HOME" .
  else
    echo "Error: GNU stow is not installed. Please install it first."
    echo "Install via: brew install stow (macOS) or apt install stow (Linux)"
    echo "Then run: stow --adopt -v -t ~ ."
    return 1
  fi
  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  elif [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
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
