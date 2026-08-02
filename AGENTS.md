# AGENTS.md

> **MANDATORY: Before any work on this repo, read [`docs/WORKFLOW.md`](docs/WORKFLOW.md) in full and follow it.**
> If `docs/WORKFLOW.md` is missing or has gaps, fix it first - see §9 (Workflow Self-Optimization) in that file.

## What This Repo Is

Personal Neovim configuration. Lua-first, lazy.nvim-managed, deployed via symlink to `~/.config/nvim`.

## Repo Structure

```
nvim-config/
├── init.lua                    # Entry point: loads config, bootstraps lazy.nvim
├── lua/
│   ├── config/                 # Core config (non-plugin)
│   │   ├── init.lua            # Loads options/keymaps/autocmds in order
│   │   ├── options.lua         # vim.opt settings
│   │   ├── keymaps.lua         # Key mappings (leader = space)
│   │   ├── autocmds.lua        # Autocommands (named augroups)
│   │   └── lazy.lua            # lazy.nvim bootstrap + setup
│   ├── plugins/                # Plugin specs (lazy auto-discovers *.lua)
│   │   └── init.lua            # Empty entry (return {})
│   └── util/
│       └── init.lua            # Shared helpers (augroup, map, has)
├── docs/
│   ├── WORKFLOW.md             # Development workflow (MANDATORY reading)
│   └── wiki/                   # User-facing config guides (Chinese)
│       └── README.md           # Index of guides (guides written post-implementation)
├── setup.sh                    # Deploy: symlink ~/.config/nvim -> repo + lazy sync
├── sync.sh                     # Pull remote updates + lazy sync
├── bootstrap.sh                # New machine: clone + setup.sh
├── AGENTS.md                   # This file (agent entry point)
├── README.md
├── CHANGELOG.md
├── .gitignore
└── lazy-lock.json              # Committed (plugin version lock, auto-generated)
```

## Development Workflow

**Read and follow [`docs/WORKFLOW.md`](docs/WORKFLOW.md).** Summary of the 8 phases:

1. **Plan** - read WORKFLOW.md + relevant config; state destination + stopping condition
2. **Edit** - one logical change; match patterns; modern API (`vim.opt`/`vim.keymap.set`/`nvim_create_autocmd`)
3. **Test** - T1 (lsp_diagnostics) + T2 (headless startup) always; T3-T5 by scope
4. **Deploy** - `./setup.sh` (symlink + lazy sync)
5. **Document** - CHANGELOG.md / README.md / AGENTS.md / WORKFLOW.md / wiki guides as relevant
6. **Skill / Workflow update** - if pattern recurs 2+ times; if gap found, update WORKFLOW.md
7. **Commit** - Conventional Commits; one change per commit; stage specific files
8. **Push** - when stable + tested; mandatory before handoff/session end/release

## Key Conventions

| Area | Rule |
|------|------|
| Config API | `vim.opt` / `vim.keymap.set` / `vim.api.nvim_create_autocmd` - not `vim.cmd` |
| Structure | `config/` = core, `plugins/<domain>.lua` = specs, `util/` = helpers |
| Commit | Conventional Commits (`feat:` / `fix:` / `docs:` / `refactor:` / `chore:`) |
| Changelog | Keep a Changelog format; `[Unreleased]` on top |
| lockfile | `lazy-lock.json` committed for reproducibility |
| Suppression | `---@diagnostic disable` forbidden unless documented + scoped |

## Decided Stack

| Component | Choice | Status |
|-----------|--------|--------|
| Plugin manager | lazy.nvim | Implemented in `lua/config/lazy.lua` |
| Completion | **blink.cmp** | Decided 2026-08-02; to be added in `lua/plugins/completion.lua` |

## Skills

When a task pattern recurs 2+ times (e.g., "add a plugin", "debug startup error"):
1. Create `.opencode/skills/<name>/SKILL.md` with fixed steps + checklist
2. Load via `skill(name="<name>")` next time

## Workflow Self-Optimization

The workflow in `docs/WORKFLOW.md` is self-improving. When you find a gap:
1. Update `docs/WORKFLOW.md` (§1-10) as part of the same change
2. Add a `### Changed` entry under `[Unreleased]` in `CHANGELOG.md`
3. Commit together with the work that revealed the gap
4. If structural (new phase / reordering), consult the user first
