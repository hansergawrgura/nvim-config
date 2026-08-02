# Development Workflow

> This file is the source of truth for how agents work on this nvim config repo.
> It is **self-improving**: when you find a gap, update this file (see §9).
>
> Agents are **required** to read this file in full before any work on the repo
> (mandated by `AGENTS.md`).

## Core Loop

```
Plan -> Edit -> Test -> Deploy -> Document -> Skill/WF update -> Commit -> Push
```

Each phase has a stopping condition. Do not skip phases.

---

## 1. Plan

- Read this file in full.
- Read `AGENTS.md` for repo overview + structure.
- Read the relevant `lua/config/*` or `lua/plugins/*` you will touch.
- State (one line): **destination** (user-visible result) + **stopping condition** (evidence of done).
- Single-file trivial fix: skip the statement, proceed to Edit.

---

## 2. Edit

- One logical change per batch; no opportunistic refactors of unrelated code.
- Match existing patterns:
  - `config/` = core settings (options, keymaps, autocmds)
  - `plugins/<domain>.lua` = plugin specs by domain
  - `util/` = shared helpers
- Use modern API: `vim.opt`, `vim.keymap.set`, `vim.api.nvim_create_autocmd`.
  Do NOT use `vim.cmd` for config unless no API exists.
- No diagnostic suppression (`---@diagnostic disable` is forbidden unless
  documented why and scoped to the minimum lines).
- Type-annotate public functions with `---@param` / `---@return`.

---

## 3. Test (tiered, stop at first failure)

| Tier | What | Command | When |
|------|------|---------|------|
| **T1** Static | Lua syntax/types | `lsp_diagnostics` on changed `.lua` files | **Always** |
| **T2** Startup | nvim starts clean | `nvim --headless -u init.lua "+qa"`; verify exit 0 | **Always** |
| **T3** Plugin sync | Plugins load | `nvim --headless "+Lazy! sync" +qa` | If `plugins/*` changed |
| **T4** Health | LSP/TS health | `nvim --headless "+checkhealth" +qa` | If LSP/Treesitter touched |
| **T5** Feature | Behavior correct | Manual verify in real nvim session | If user-visible change |

> **Note on T1**: `lua-language-server` may flag `vim.*` globals as unknown
> until the `neodev.nvim` / `lazydev.nvim` plugin is added to provide nvim
> type annotations. Treat `vim.*` "undefined-global" warnings as expected
> until then; real type errors still must be fixed.

T1 and T2 are mandatory for every change. T3-T5 apply when their scope matches.

---

## 4. Deploy (Sync)

- Run `./setup.sh`: recreates symlink `~/.config/nvim -> repo` (overwriting
  existing target with backup) + `nvim --headless "+Lazy! sync" +qa`.
- Verify: `readlink -f ~/.config/nvim` points to the repo.
- T5 (feature verification) happens after deploy, in a real nvim session.

---

## 5. Document (update what is relevant)

| File | When | What to update |
|------|------|----------------|
| `CHANGELOG.md` | Every user-visible change | `[Unreleased]` entry (Added/Changed/Fixed/Removed) |
| `README.md` | Install/usage/structure changed | Corresponding section |
| `AGENTS.md` | Structure/conventions/overview changed | Corresponding section |
| `docs/WORKFLOW.md` | Workflow itself changed | This file (see §9) |
| `lazy-lock.json` | Plugin versions changed | Auto-generated; commit as-is |
| `docs/wiki/` | User-facing feature added/changed | Create or update the relevant guide (see §10) |

---

## 6. Skill / Workflow Update (conditional, not every time)

### Skill creation
- **Trigger**: a task pattern recurs 2+ times (e.g., "add a plugin", "debug startup error").
- **Location**: `.opencode/skills/<name>/SKILL.md`.
- **Content**: fixed steps + checklist for that task.
- **Usage**: load via `skill(name="<name>")` next time.

### Workflow self-update
- **Trigger**: you discovered a gap in THIS workflow (missing test step, unclear convention, uncovered change type).
- **Action**: update `docs/WORKFLOW.md` §1-9 as part of the same change.
- **Commit** the workflow update together with the work that revealed the gap.

---

## 7. Commit

- **Conventional Commits**: `feat:` / `fix:` / `docs:` / `refactor:` / `chore:` / `style:`.
- One logical change per commit. Do not bundle a feature with an unrelated refactor.
- Stage specific files: `git add <file1> <file2>`.
  Avoid `git add -A` unless all changes are intended.
- `lazy-lock.json` commits alongside the plugin spec change that caused it.
- Commit body explains WHY (when non-obvious).

---

## 8. Push (when appropriate)

- **Push**: tests pass + committed + stable.
- **Do NOT push**: WIP, broken, untested intermediate state.
- **MUST push before**: handing off to user, ending session, tagging a release.

---

## 9. Workflow Self-Optimization

This workflow is not static. It evolves with the repo.

When you find a gap (missing step, unclear rule, new change type not covered):

1. Update the relevant section (§1-10) of this file.
2. Add a `### Changed` entry under `[Unreleased]` in `CHANGELOG.md` noting the workflow improvement.
3. Commit the workflow update together with the work that revealed the gap (same commit or adjacent).
4. If the gap is structural (new phase needed, phase reordering), consult the user before restructuring.

This §9 clause is itself the mechanism that keeps the workflow alive.
Treat updating this file as a first-class deliverable, not an afterthought.

---

## 10. Config Wiki Guides

The wiki is a series of user-facing guides in `docs/wiki/` explaining how to
use and customize this configuration. It is maintained alongside the code.

### Location
- `docs/wiki/README.md` - index of all guides
- `docs/wiki/<topic>.md` - one guide per topic

### When to create or update a guide
- **Create** a new guide when you add a feature users need to learn
  (new plugin, new keybinding group, new workflow).
- **Update** an existing guide when a feature's usage changes
  (keybindings remapped, options renamed, behavior altered).
- **Check** during Phase 5 (Document) whether any guide is now stale.

### Timing
Guides are written in **Phase 5 (Document)**, after Edit + Test + Deploy
(Phases 2-4) are complete and verified. Do not write guide content during
implementation - write it after the feature works and is tested.

### Guide format
- Written in **Simplified Chinese** (简体中文).
- Clear title + one-line description at the top.
- "涵盖内容" section listing the scope.
- Code examples where relevant (code stays in English).
- "相关指南" section linking to related entries.
- Add an entry to the index table in `docs/wiki/README.md`.

### Current guides
See `docs/wiki/README.md` for the up-to-date list.

---

## Quick Reference

```bash
# T2: startup test
nvim --headless -u init.lua "+qa" && echo "T2 OK"

# T3: plugin sync
nvim --headless "+Lazy! sync" +qa

# Deploy
./setup.sh

# Commit (example)
git add lua/config/options.lua CHANGELOG.md
git commit -m "feat(options): set relativenumber and scrolloff"
```
