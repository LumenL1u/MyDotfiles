# AGENTS.md

## Repository overview

Personal dotfiles managed by GNU Stow. Primary target is macOS; Linux is secondary.

## Architecture

- **Stow model**: Files at repo root are symlinked into `$HOME` via `stow --adopt -v -t "$HOME" .`
- **`.stow-local-ignore`**: Excludes `README*`, `LICENSE*`, `bootstrap.sh`, `pluginstall.sh` from symlinking
- **Shell stack**: Zsh + Oh My Zsh + Powerlevel10k
- **Editor**: Neovim with lazy.nvim (config in `.config/nvim/`)
- **Terminal**: Alacritty (`.config/alacritty/`) and iTerm2 (`.config/iterm2/`)
- **Multiplexer**: tmux with tpm (plugins auto-install via tpm)

## Key files and their roles

| Path | Purpose |
|------|---------|
| `bootstrap.sh` | Entry point: pulls latest, runs `pluginstall.sh`, then `stow --adopt` |
| `pluginstall.sh` | Installs fonts, Homebrew/apt packages, Oh My Zsh, zsh plugins, Neovim plugins |
| `.zshrc` | Sources Oh My Zsh, then loads `.path .exports .aliases .functions .extra` in order |
| `.path` | PATH setup (Homebrew, ~/.local/bin) |
| `.exports` | Environment variables (EDITOR, LANG, HISTSIZE, etc.) |
| `.aliases` | Shell aliases (navigation, git shortcuts, macOS utilities) |
| `.functions` | Shell functions (mkd, server, tre, etc.) |
| `.extra` | Modern CLI overrides: eza→ls, bat→cat, fd→find, zoxide→cd, nvim→vi/vim |
| `.tmux.conf` | tmux config with vim-style keybindings and plugins |
| `.gitconfig` | Git aliases (st, lg, cm, undo, amend, wip) and URL shorthands |
| `.p10k.zsh` | Powerlevel10k prompt configuration |

## Neovim config structure

```
.config/nvim/
├── init.lua                  # Entry: requires config.lazy
├── lazy-lock.json            # Plugin version lockfile
└── lua/
    ├── config/
    │   ├── lazy.lua          # lazy.nvim bootstrap and setup
    │   ├── options.lua       # Vim options
    │   ├── keymaps.lua       # Key mappings
    │   ├── lsp.lua           # LSP configuration
    │   └── autocmds.lua      # Autocommands
    └── plugins/
        ├── core.lua          # Core plugins
        ├── nvim-lsp.lua      # LSP server configs
        ├── mason.lua         # Mason LSP installer
        ├── nvim-cmp.lua      # Completion
        ├── telescope.lua     # Fuzzy finder
        ├── treesitter.lua    # Syntax highlighting
        ├── formatting.lua    # Formatter config
        ├── linting.lua       # Linter config
        └── ...               # Other plugin specs
```

## Bootstrap behavior

`bootstrap.sh` does:
1. `git pull origin main`
2. Runs `pluginstall.sh` (installs all dependencies)
3. `stow --adopt -v -t "$HOME" .` (symlinks everything)

**Warning**: `--adopt` moves existing files from `$HOME` into the repo. If a file already exists at `~/.zshrc`, stow will move it into the repo and replace it with a symlink. This is intentional for initial setup but means running bootstrap on a machine with existing dotfiles will overwrite repo contents.

## Shell loading order

`.zshrc` sources files in this sequence:
1. Oh My Zsh (`$ZSH/oh-my-zsh.sh`)
2. `.path` — PATH additions
3. `.bash_prompt` — (if exists)
4. `.exports` — environment variables
5. `.aliases` — shell aliases
6. `.functions` — shell functions
7. `.extra` — modern CLI tool overrides (eza, bat, fd, zoxide, nvim)
8. `.p10k.zsh` — prompt config
9. `.fzf.zsh` — fzf integration (if exists)

## Git shortcuts (from .gitconfig)

- `git st` — short status
- `git lg` — pretty log graph (last 20)
- `git cm "msg"` — commit with message
- `git undo` — soft reset last commit
- `git amend` — amend last commit (no edit)
- `git wip` — stage all and commit as "WIP"
- `git dfc` — staged diff

## Alacritty notes

- Uses coolnight theme by default (imported in `alacritty.toml`)
- Font: MesloLGS NF (Nerd Font, required for Powerlevel10k)
- Cmd+H/J/K/L mapped to arrow keys for vim-style navigation
- `option_as_alt = 'Both'` enables Alt-key shortcuts in terminal

## tmux notes

- Prefix is default `C-b`
- Split: `|` for horizontal, `-` for vertical (opens in current path)
- `r` reloads config
- `h/j/k/l` resize panes (5 units)
- `m` toggle zoom
- Vi copy mode: `v` to select, `y` to copy
- Plugins: vim-tmux-navigator, tmux-power, tmux-resurrect, tmux-continuum

## Proxy configuration

Default proxy address: `http://127.0.0.1:7890`

Toggle with `proxy_on` / `proxy_off` functions defined in `.zshrc`.

## Package management

- **macOS**: Homebrew (`/opt/homebrew`)
- **Linux**: apt (with Aliyun mirror for Ubuntu)
- Key packages: neovim, eza, bat, fd, zoxide, ripgrep, lazygit, tmux, shfmt, tree-sitter

## Conventions

- Shell scripts use `#!/usr/bin/env bash` shebang
- Neovim is the default editor (`$EDITOR`, `$VISUAL`)
- `cd` is aliased to `zoxide` (via `.extra`) — use `builtin cd` if you need the real cd
- `cat` is aliased to `bat --paging=never`
- `find` is aliased to `fd`
- `vi`/`vim` are aliased to `nvim`
- Git default branch is `main`
- npm registry is set to npmmirror.com (Chinese mirror)

## When editing configs

- **Shell files** (`.zshrc`, `.aliases`, `.exports`, `.functions`, `.extra`, `.path`): Changes take effect after `exec zsh` or `source ~/.zshrc`
- **Neovim configs** (`.config/nvim/lua/**`): Changes take effect on next Neovim launch; lazy.nvim handles plugin sync automatically
- **tmux config** (`.tmux.conf`): Reload with `tmux source-file ~/.tmux.conf` or press `prefix + r` inside tmux
- **Alacritty config** (`.config/alacritty/alacritty.toml`): Auto-reloads on save
- **Git config** (`.gitconfig`): Changes take effect immediately for new git commands

## Do not

- Edit `.p10k.zsh` manually — run `p10k configure` instead
- Run `bootstrap.sh` on a machine with existing dotfiles without understanding `--adopt` behavior
- Modify `pluginstall.sh` without testing on both macOS and Linux paths
- Add files to repo root that should not be symlinked — update `.stow-local-ignore` first
