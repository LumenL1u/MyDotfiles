# MyDotfiles

使用 GNU Stow 管理的个人 dotfiles。

## 包含内容

| 组件 | 技术栈 |
|-----------|------------|
| Shell | Oh My Zsh + Powerlevel10k |
| 终端 | WezTerm（macOS / Linux / Windows 通用） |
| 编辑器 | Neovim (lazy.nvim) |
| 复用器 | Herdr |
| 现代 CLI | eza, bat, fd, zoxide, ripgrep, lazygit |

## 目录结构

- `.zshrc` / `.p10k.zsh` — zsh 与提示符
- `.aliases` — 跨平台共享别名
- `.aliases.macos` / `.aliases.linux` — 平台专属别名
- `.functions` / `.exports` / `.extra` / `.path` — 函数、环境变量、工具别名、PATH（机器本地覆盖放 `~/.exports.local`）
- `.gitconfig` — 通用 git 配置
- `.config/herdr` — Herdr 终端工作区管理器
- `.config/wezterm` — WezTerm 跨平台终端配置
- `.config/nvim` — Neovim (lazy.nvim)

## 快速开始

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

## 手动步骤

1. 在终端设置中选择「MesloLGS NF」字体
2. 运行 `p10k configure` 自定义提示符
3. 机器本地配置（git 身份/代理、密钥等）请在 `$HOME` 手动维护，例如 `~/.gitconfig.local`（`.gitconfig` 会自动 include）、`~/.exports.local`（`.zshrc` 会自动 source，且已被 `.gitignore` 忽略，不会误提交）

## 常用快捷键与别名

### Git 别名
- `git st` - 简洁状态
- `git lg` - 美化日志图
- `git cm "msg"` - 提交并附带信息
- `git undo` - 撤销上一次提交（soft）
- `git amend` - 修补上一次提交

### 现代 CLI
- `ll` - 使用 eza 列出文件
- `cat` - 使用 bat 查看文件
- `z` - 使用 zoxide 跳转目录
- `h` - Herdr 简写（`ha` 附加会话，`hl` 查看状态）

### 代理
- `proxy_on` - 开启终端代理（地址由环境变量 `PROXY_ADDR` 覆盖）
- `proxy_off` - 关闭终端代理
