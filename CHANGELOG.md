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
- **blink.cmp** completion (LSP/path/buffer/snippet sources) in `lua/plugins/completion.lua`
- **mason.nvim + nvim-lspconfig** for 13 LSP servers in `lua/plugins/lsp.lua`
- **LuaSnip + friendly-snippets** snippet engine in `lua/plugins/snippets.lua`
- **nvim-autopairs** for bracket/quote auto-closing in `lua/plugins/autopairs.lua`
- **nvim-treesitter** for syntax highlighting and language-aware indentation in `lua/plugins/treesitter.lua`
- File header auto-insertion (Author/Date/File/Description) on BufNewFile
- Custom main function snippets for Python/C/C++/Java/Go/Rust + HTML5 boilerplate in `snippets/`
- `docs/wiki/` Chinese guides: 快速开始, 快捷键, 配置结构
- Leader 快捷键：`<leader>w` 保存、`<leader>q` 退出、`<leader>x` 保存并退出

### Changed
- `docs/WORKFLOW.md` §10: added Config Wiki Guides maintenance rules to the workflow

### Fixed
- Migrated LSP config to `vim.lsp.config()` / `vim.lsp.enable()` (nvim 0.11+ API), fixing deprecation warning and `:q!` hang
- Replaced `smartindent` with Treesitter `indent = { enable = true }`, fixing auto-indent on newline
