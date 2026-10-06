# MyDotfiles

Personal dotfiles managed by GNU Stow.

## What's Included

| Component | Tech Stack |
|-----------|------------|
| Shell | Oh My Zsh + Powerlevel10k |
| Terminal | Alacritty（macOS / Linux 通用） |
| Editor | Neovim (lazy.nvim) |
| Multiplexer | tmux (tpm) |
| Modern CLI | eza, bat, fd, zoxide, ripgrep, lazygit |

## 目录结构

- `.zshrc` / `.p10k.zsh` — zsh 与提示符
- `.aliases` — 跨平台共享别名
- `.aliases.macos` / `.aliases.linux` — 平台专属别名
- `.functions` / `.exports` / `.extra` / `.path` — 函数、环境变量、工具别名、PATH
- `.gitconfig` — 通用 git 配置（代理请放 `~/.gitconfig.local`）
- `.gitconfig.local.example` — 机器本地 git 配置模板（不入库）
- `.tmux.conf` — tmux + tpm
- `.config/alacritty` — Alacritty 配置与主题
- `.config/nvim` — Neovim (lazy.nvim)

## Quick Start

### macOS

```bash
# 1. 安装 Xcode Command Line Tools
xcode-select --install

# 2. 克隆仓库
git clone git@github.com:LumenL1u/MyDotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. 一键安装（Homebrew + 字体 + CLI + zsh 插件 + stow 链接）
./bootstrap.sh

# 4. 手动：终端字体选择 MesloLGS NF
```

### Ubuntu / Debian

```bash
# 1. 安装基础依赖
sudo apt update
sudo apt install -y zsh git stow curl wget build-essential

# 2. 克隆仓库
git clone git@github.com:LumenL1u/MyDotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. 一键安装（apt 包 + 字体 + zsh 插件 + stow 链接）
./bootstrap.sh

# 4. 若 .zshrc 里 locale 报错，生成 UTF-8 locale
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

# 5. 手动：终端字体选择 MesloLGS NF
```

> 需要国内镜像（仅 Debian/Ubuntu 生效）：
> `MIRROR_CN=1 ./bootstrap.sh`

### Fedora / Arch

`pluginstall.sh` 已支持 `dnf` 与 `pacman`，克隆后直接 `./bootstrap.sh` 即可。
Fedora 若 `fd`/`bat` 命令不存在，脚本会自动创建 `fdfind→fd`、`batcat→bat` 软链。

## Manual Steps

1. Select "MesloLGS NF" font in your terminal settings
2. Run `p10k configure` to customize your prompt
3. 复制并填写本地 git 配置：`cp ~/.gitconfig.local.example ~/.gitconfig.local`

## Useful Shortcuts

### Git Aliases
- `git st` - Short status
- `git lg` - Pretty log graph
- `git cm "msg"` - Commit with message
- `git undo` - Undo last commit (soft)
- `git amend` - Amend last commit

### Modern CLI
- `ll` - List files with eza
- `cat` - View files with bat
- `z` - Jump directories with zoxide
- `t` - tmux shorthand

### Proxy
- `proxy_on` - Enable terminal proxy（地址由环境变量 `PROXY_ADDR` 覆盖）
- `proxy_off` - Disable terminal proxy
