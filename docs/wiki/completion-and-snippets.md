# 补全与代码片段

blink.cmp 代码补全与 LuaSnip 代码片段的使用说明。

## 涵盖内容

- 代码补全（blink.cmp）
- LSP 服务器（mason + lspconfig）
- 代码片段（LuaSnip + friendly-snippets）
- 文件头自动插入
- 主函数模板

## 代码补全

补全引擎为 **blink.cmp**（Rust 核心，高性能）。配置在 `lua/plugins/completion.lua`。

### 补全源

| 源 | 功能 |
|------|------|
| `lsp` | LSP 补全（函数、变量、类型等） |
| `path` | 文件路径补全 |
| `snippets` | 代码片段补全（来自 LuaSnip） |
| `buffer` | 当前缓冲区文本补全 |

### 快捷键

| 按键 | 功能 |
|------|------|
| `<C-Space>` | 显示补全菜单 / 文档 |
| `<CR>` | 确认补全 |
| `<Tab>` | 选择下一个 / 跳到下一个占位符 |
| `<S-Tab>` | 选择上一个 / 跳到上一个占位符 |
| `<C-e>` | 关闭补全菜单 |

## LSP 服务器

通过 **mason.nvim** 自动安装，**nvim-lspconfig** 配置。配置在 `lua/plugins/lsp.lua`。

### 支持的语言

| 语言 | LSP 服务器 |
|------|------------|
| Python | pyright |
| Java | jdtls |
| C / C++ | clangd |
| TypeScript / JavaScript | ts_ls |
| HTML | html |
| CSS | cssls |
| Go | gopls |
| Rust | rust_analyzer |
| Lua | lua_ls |
| Bash | bashls |
| JSON | jsonls |
| YAML | yamlls |
| Markdown | marksman |

首次打开对应语言的文件时，mason 会自动安装所需的 LSP 服务器。

## 代码片段

片段引擎为 **LuaSnip**，预置 **friendly-snippets** 片段库。配置在 `lua/plugins/snippets.lua`。

### 自定义片段

项目自定义片段在 `snippets/` 目录，VSCode JSON 格式：

| 文件 | 前缀 | 展开内容 |
|------|------|----------|
| `python.json` | `main` | `if __name__ == "__main__":` |
| `c.json` | `main` | C main 函数 |
| `cpp.json` | `main` | C++ main 函数 |
| `java.json` | `main` / `mainclass` | main 方法 / 带 main 的类 |
| `go.json` | `main` | package main + func main |
| `rust.json` | `main` | fn main |
| `html.json` | `html5` | HTML5 模板 |

输入对应前缀（如 `main`），补全菜单会显示片段，按 `<CR>` 确认。

## 文件头自动插入

创建新文件时，自动在文件顶部插入头部信息：

```
# Author: YoboMya
# Date: 2026-08-02
# File: example.py
# Description: 
```

注释风格根据文件类型自动适配：

| 风格 | 适用语言 |
|------|----------|
| `#` | Python, Shell, YAML, TOML, R, ... |
| `//` | C, C++, Java, JS, TS, Go, Rust, ... |
| `--` | Lua, Haskell, SQL |
| `/* */` | CSS, SCSS |
| `<!-- -->` | HTML, XML, Markdown |

作者名从 `git config user.name` 获取，日期为当前日期。

## 相关指南

- [快速开始](getting-started.md)
- [快捷键](keybindings.md)
- [配置结构](structure.md)
