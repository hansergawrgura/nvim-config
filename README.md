# nvim-config

Personal Neovim configuration. Lua-first, lazy.nvim-managed.

## Requirements

- Neovim >= 0.11
- Git
- A Nerd Font (for icons)
- External tools (recommended): `ripgrep`, `fd`, `node`

## Quick Start (New Machine)

```bash
git clone https://github.com/hansergawrgura/nvim-config.git ~/01-Repo/00-Config/nvim.config
cd ~/01-Repo/00-Config/nvim.config
./setup.sh
```

Or via bootstrap script:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hansergawrgura/nvim-config/main/bootstrap.sh)
```

## Update Workflow

| Scenario | Command | What it does |
|----------|---------|--------------|
| After editing locally | `./setup.sh` | Symlink deploy + lazy sync |
| Pull updates on another machine | `./sync.sh` | `git pull` + lazy sync |
| New machine | `./bootstrap.sh` | Clone + `setup.sh` |

## Structure

See [AGENTS.md](AGENTS.md) for the full repo structure and conventions.

## Development

Agents working on this repo **must** read [`docs/WORKFLOW.md`](docs/WORKFLOW.md) before making changes.

A standalone, offline-friendly deep-dive tutorial is also available: [`docs/nvim-mastery-guide.html`](docs/nvim-mastery-guide.html). It covers modal editing, Leader mappings, windows/buffers, completion, LSP, HTML workflows, configuration, and a 30-day practice plan.

## Changelog

See [CHANGELOG.md](CHANGELOG.md).
