# Changelog

All notable changes to this nvim configuration are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added
- Initial nvim config skeleton: `init.lua`, `lua/config/{init,options,keymaps,autocmds,lazy}.lua`, `lua/util/init.lua`, `lua/plugins/init.lua`
- Deploy scripts: `setup.sh` (symlink deploy + lazy sync), `sync.sh` (pull + sync), `bootstrap.sh` (new machine)
- `AGENTS.md` with repo overview, conventions, and mandatory workflow reference
- `docs/WORKFLOW.md` - 8-phase development workflow with self-optimization (§9)
- `README.md` and `CHANGELOG.md`
- Decided completion stack: **blink.cmp** (to be added in `lua/plugins/completion.lua`)
- `docs/wiki/` Chinese guides: 快速开始, 快捷键, 配置结构

### Changed
- `docs/WORKFLOW.md` §10: added Config Wiki Guides maintenance rules to the workflow
