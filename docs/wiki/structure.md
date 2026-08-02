# 配置结构

本 Neovim 配置的文件组织方式。

## 涵盖内容

- 目录结构
- 各目录职责
- 插件加载机制
- 如何扩展配置

## 目录结构

```
nvim-config/
├── init.lua                # 入口：加载核心配置，引导 lazy.nvim
├── lua/
│   ├── config/             # 核心设置（非插件）
│   │   ├── init.lua        # 按序加载 options/keymaps/autocmds
│   │   ├── options.lua     # vim.opt 设置
│   │   ├── keymaps.lua     # 快捷键映射（leader = 空格）
│   │   ├── autocmds.lua    # 自动命令（命名 augroup）
│   │   └── lazy.lua        # lazy.nvim 引导与配置
│   ├── plugins/            # 插件规格（lazy.nvim 自动发现）
│   │   └── init.lua        # 空入口（return {}）
│   └── util/
│       └── init.lua        # 公共工具函数（augroup、map、has）
├── docs/
│   ├── WORKFLOW.md         # 开发工作流（面向 agent）
│   └── wiki/               # 用户指南（本文件所在）
├── setup.sh                # 部署：创建符号链接 + lazy sync
├── sync.sh                 # 拉取更新 + lazy sync
├── bootstrap.sh            # 新机器：clone + setup.sh
└── lazy-lock.json          # 插件版本锁定（已提交）
```

## 各目录职责

| 目录 | 用途 | 何时添加 |
|------|------|----------|
| `lua/config/` | 核心 Neovim 设置 | 添加选项、快捷键或自动命令时 |
| `lua/plugins/` | 插件规格 | 添加新插件时 |
| `lua/util/` | 公共工具函数 | 添加可复用的工具代码时 |
| `docs/wiki/` | 用户指南 | 功能需要用户文档时 |

## 插件加载机制

lazy.nvim 会自动发现 `lua/plugins/` 下的所有 `*.lua` 文件。
每个文件返回一个插件规格表：

```lua
-- lua/plugins/example.lua
return {
  "author/plugin-name",
  opts = {},
  keys = {},
}
```

你**不需要**手动 require 这些文件 -- lazy.nvim 会自动处理。

## 如何扩展

### 添加新选项

编辑 `lua/config/options.lua`：

```lua
vim.opt.relativenumber = true
```

### 添加新快捷键

编辑 `lua/config/keymaps.lua`：

```lua
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "保存文件" })
```

### 添加新插件

创建 `lua/plugins/<领域>.lua`（如 `git.lua`、`ui.lua`）：

```lua
return {
  "lewis6991/gitsigns.nvim",
  opts = {},
}
```

下次启动时 lazy.nvim 会自动发现。

### 添加新自动命令

编辑 `lua/config/autocmds.lua`：

```lua
autocmd("InsertEnter", {
  group = augroup("MyGroup", { clear = true }),
  callback = function() ... end,
  desc = "进入插入模式时执行",
})
```

## 相关指南

- [快速开始](getting-started.md)
- [快捷键](keybindings.md)
