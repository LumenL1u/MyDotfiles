# AGENTS.md

## Repository overview

Personal dotfiles managed by GNU Stow. Primary target is macOS; Linux is secondary.

## Architecture

- **Stow model**: Files at repo root are symlinked into `$HOME` via `stow --adopt -v -t "$HOME" .`
- **`.stow-local-ignore`**: Excludes `README*`, `LICENSE*`, `bootstrap.sh`, `pluginstall.sh` from symlinking
- **Shell stack**: Zsh + Oh My Zsh + Powerlevel10k
- **Editor**: Neovim with lazy.nvim (config in `.config/nvim/`)
- **Terminal**: WezTerm (`.config/wezterm/`) — cross-platform (macOS / Linux / Windows)
- **Multiplexer**: Herdr (terminal workspace manager, config in `.config/herdr/`)

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
| `.config/herdr/config.toml` | Herdr keybindings, terminal defaults (prefix ctrl+b) |
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

## WezTerm notes

- Config: `.config/wezterm/wezterm.lua` (Lua, cross-platform)
- Colors: coolnight theme (same palette as previous Alacritty setup)
- Font: MesloLGS NF (Nerd Font, required for Powerlevel10k)
- Window: opacity 0.8, macOS background blur, padding 10, no title bar (RESIZE)
- Alt key sends Meta (ESC prefix) for vim/herdr shortcuts

## Herdr notes

- Prefix is default `ctrl+b` (same as tmux); prefix-free `ctrl+alt+h/j/k/l` also moves panes
- New tab `prefix+c`, split right `prefix+v`, split down `prefix+minus`
- Move panes `prefix+h/j/k/l`, zoom `prefix+z`, close pane `prefix+x`, resize `prefix+r`
- Vi copy mode: `prefix+[` then `v` to select, `y` to copy, `q` to exit
- Detach `prefix+q`; goto picker `prefix+g`; keybind help `prefix+?`
- Mouse-native: click/drag/resize work without keybindings
- Config: `.config/herdr/config.toml`; reload with `herdr server reload-config`

## Proxy configuration

Default proxy address: `http://127.0.0.1:7890`

Toggle with `proxy_on` / `proxy_off` functions defined in `.zshrc`.

## Package management

- **macOS**: Homebrew (`/opt/homebrew`)
- **Linux**: apt (with Aliyun mirror for Ubuntu)
- Key packages: neovim, eza, bat, fd, zoxide, ripgrep, lazygit, herdr, shfmt, tree-sitter

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
- **Herdr config** (`.config/herdr/config.toml`): Reload with `herdr server reload-config`
- **WezTerm config** (`.config/wezterm/wezterm.lua`): Reload with `Ctrl+Shift+R` or restart WezTerm
- **Git config** (`.gitconfig`): Changes take effect immediately for new git commands

## Do not

- Edit `.p10k.zsh` manually — run `p10k configure` instead
- Run `bootstrap.sh` on a machine with existing dotfiles without understanding `--adopt` behavior
- Modify `pluginstall.sh` without testing on both macOS and Linux paths
- Add files to repo root that should not be symlinked — update `.stow-local-ignore` first
