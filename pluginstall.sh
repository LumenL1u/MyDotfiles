#!/usr/bin/env bash

# ==================== install Nerd Font====================
echo "Installing fonts..."
if [[ $OSTYPE == "darwin"* ]]; then
  FONT_DIR="$HOME/Library/Fonts"
  IS_MAC=true
  if ! type brew &>/dev/null; then
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
    curl -fsSL "$URL/$file" -o "/$local_path"
  fi
  if [[ $? -eq 0 ]]; then
    echo "  ✓ $local_path"
  else
    echo "  ✗ $local_path/"
    rm -f "$local_path"
  fi
done
if [ "$IS_MAC" = false ] && type fc-cache &>/dev/null; then
  fc-cache -fv
fi

# ==================== install modern CLI tools & Neovim ====================
echo "Installing modern CLI tools and Neovim..."
if [[ -f /etc/apt/sources.list.d/ubuntu.sources ]]; then
  sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak
  sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g; s|http://security.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
fi
if type brew &>/dev/null; then
  NONINTERACTIVE=1 brew install \
    neovim tldr zoxide eza bat ripgrep fd node tmux python3 \
    tree-sitter tree-sitter-cli lazygit shfmt isort black stow
elif type apt &>/dev/null; then
  sudo apt update && sudo apt install -y \
    neovim tldr zoxide eza bat ripgrep fd-find zsh nodejs npm tmux python3 \
    python3-pip tree-sitter tree-sitter-cli lazygit shfmt isort black stow
  if ! type fd &>/dev/null && type fdfind &>/dev/null; then
    sudo ln -s $(which fdfind) /usr/local/bin/fd
  fi
  if ! type bat &>/dev/null && type batcat &>/dev/null; then
    sudo ln -s $(which batcat) /usr/local/bin/bat
  fi
fi
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
npm config set registry https://registry.npmmirror.com &>/dev/null
tldr --update &>/dev/null

# ==================== set Zsh as default shell====================
CURRENT_SHELL=$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')
[ -z "$CURRENT_SHELL" ] && CURRENT_SHELL="$SHELL"

if [[ $CURRENT_SHELL != */zsh ]]; then
  echo "Changing your default shell to Zsh..."
  chsh -s $(which zsh)
fi

# ==================== install Oh My Zsh ====================
echo "Checking and installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  env CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

# ==================== install Neovim plugins ====================
echo "Installing Neovim plugins via lazy.nvim..."
nvim --headless "+Lazy! sync" +qa &>/dev/null

# ==================== install Zsh plugins ====================
echo "Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"
mkdir -p "$ZSH_CUSTOM/themes"

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "Done! Please restart your terminal or run 'exec zsh' to enjoy your new environment."
