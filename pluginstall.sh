#!/usr/bin/env bash
#
# pluginstall.sh - 安装字体、CLI 工具、zsh 插件等
# 支持：macOS(brew)、Debian/Ubuntu(apt)、Fedora(dnf)、Arch(pacman)
#
# 用法：
#   ./pluginstall.sh            # 默认，不改系统镜像源
#   MIRROR_CN=1 ./pluginstall.sh # 使用国内镜像源（仅 Debian/Ubuntu）

set -euo pipefail

# ==================== install Nerd Font ====================
echo "Installing fonts..."
if [[ "$OSTYPE" == darwin* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
    IS_MAC=true
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
        if [[ -f /opt/homebrew/bin/brew ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >>~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
else
    FONT_DIR="$HOME/.local/share/fonts"
    IS_MAC=false
fi
mkdir -p "$FONT_DIR"

URL="https://github.com/romkatv/powerlevel10k-media/raw/master"
FILES=("MesloLGS%20NF%20Regular.ttf" "MesloLGS%20NF%20Bold.ttf" "MesloLGS%20NF%20Italic.ttf" "MesloLGS%20NF%20Bold%20Italic.ttf")
for file in "${FILES[@]}"; do
    local_name="${file//%20/ }"
    local_path="$FONT_DIR/$local_name"
    if [[ -f $local_path ]]; then
        echo "  - $local_path (skip)"
        continue
    fi
    if command -v wget &>/dev/null; then
        wget -q "$URL/$file" -O "$local_path"
    else
        curl -fsSL "$URL/$file" -o "$local_path"
    fi
    if [[ $? -eq 0 ]]; then
        echo "  ✓ $local_path"
    else
        echo "  ✗ $local_path"
        rm -f "$local_path"
    fi
done
if [ "$IS_MAC" = false ] && command -v fc-cache &>/dev/null; then
    fc-cache -fv >/dev/null
fi

# ==================== 可选：国内镜像源（仅 Debian/Ubuntu） ====================
if [[ "${MIRROR_CN:-0}" == "1" ]] && [[ -f /etc/apt/sources.list.d/ubuntu.sources ]]; then
    echo "Switching Ubuntu apt mirror to Aliyun (MIRROR_CN=1)..."
    sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak
    sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g; s|http://security.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
fi

# ==================== install modern CLI tools & Neovim ====================
echo "Installing modern CLI tools and Neovim..."
if command -v brew &>/dev/null; then
    brew install \
        neovim tldr zoxide eza bat ripgrep fd node tmux python3 \
        tree-sitter tree-sitter-cli lazygit shfmt isort black stow
elif command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y \
        neovim tldr zoxide eza bat ripgrep fd-find zsh nodejs npm tmux python3 \
        python3-pip tree-sitter tree-sitter-cli lazygit shfmt isort black stow \
        ncurses-term # tmux-256color terminfo
    # Debian/Ubuntu 包名差异：fd-find -> fd, batcat -> bat
    if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
        sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    fi
    if ! command -v bat &>/dev/null && command -v batcat &>/dev/null; then
        sudo ln -sf "$(command -v batcat)" /usr/local/bin/bat
    fi
elif command -v dnf &>/dev/null; then
    sudo dnf install -y \
        neovim tldr zoxide eza bat ripgrep fd-find zsh nodejs npm tmux python3 \
        python3-pip tree-sitter lazygit shfmt isort black stow ncurses-term
    if ! command -v fd &>/dev/null && command -v fdfind &>/dev/null; then
        sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
    fi
elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm \
        neovim tldr zoxide eza bat ripgrep fd zsh nodejs npm tmux python \
        python-pip tree-sitter lazygit shfmt isort black stow ncurses
else
    echo "Warning: 未检测到支持的包管理器 (brew/apt/dnf/pacman)，请手动安装依赖。"
fi

# tpm (tmux plugin manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# 可选：npm 国内镜像
if [[ "${MIRROR_CN:-0}" == "1" ]]; then
    npm config set registry https://registry.npmmirror.com >/dev/null 2>&1 || true
fi
command -v tldr &>/dev/null && tldr --update >/dev/null 2>&1 || true

# ==================== set Zsh as default shell ====================
ZSH_BIN="$(command -v zsh || true)"
if [[ -n "$ZSH_BIN" ]]; then
    if [[ "$OSTYPE" == darwin* ]]; then
        CURRENT_SHELL=$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')
    else
        CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
    fi
    [ -z "$CURRENT_SHELL" ] && CURRENT_SHELL="$SHELL"

    if [[ "$CURRENT_SHELL" != "$ZSH_BIN" ]]; then
        echo "Changing your default shell to Zsh..."
        if [[ "$OSTYPE" == darwin* ]]; then
            chsh -s "$ZSH_BIN"
        else
            # 确保 zsh 在 /etc/shells 里，再改默认 shell
            grep -qxF "$ZSH_BIN" /etc/shells || echo "$ZSH_BIN" | sudo tee -a /etc/shells >/dev/null
            sudo chsh -s "$ZSH_BIN" "$USER"
        fi
    fi
else
    echo "Warning: zsh 未安装，跳过默认 shell 设置。"
fi

# ==================== install Oh My Zsh ====================
echo "Checking and installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    env CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# ==================== install Zsh plugins ====================
echo "Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

declare -A ZSH_PLUGINS=(
    [themes/powerlevel10k]="https://github.com/romkatv/powerlevel10k.git"
    [plugins/zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
    [plugins/zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
    [plugins/zsh-vi-mode]="https://github.com/jeffreytse/zsh-vi-mode"
)
for dir in "${!ZSH_PLUGINS[@]}"; do
    if [ ! -d "$ZSH_CUSTOM/$dir" ]; then
        git clone --depth=1 "${ZSH_PLUGINS[$dir]}" "$ZSH_CUSTOM/$dir"
    else
        echo "  - $dir (skip)"
    fi
done

# ==================== install Neovim plugins ====================
if command -v nvim &>/dev/null; then
    echo "Installing Neovim plugins via lazy.nvim..."
    nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1 || true
fi

echo "Done! Please restart your terminal or run 'exec zsh' to enjoy your new environment."
