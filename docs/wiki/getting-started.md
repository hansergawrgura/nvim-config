# 快速开始

如何安装并开始使用本 Neovim 配置。

## 涵盖内容

- 前置要求
- 安装步骤
- 首次启动
- 验证安装

## 前置要求

- Neovim >= 0.11
- Git
- Nerd Font（用于图标显示，如 JetBrains Mono Nerd Font）
- 推荐工具：`ripgrep`、`fd`、`node`

## 安装

### 新机器

```bash
git clone https://github.com/hansergawrgura/nvim-config.git ~/01-Repo/00-Config/nvim.config
cd ~/01-Repo/00-Config/nvim.config
./setup.sh
```

`setup.sh` 会：

1. 创建符号链接 `~/.config/nvim -> ~/01-Repo/00-Config/nvim.config`（已有配置会自动备份）
2. 运行 `Lazy! sync` 安装插件
3. 检查外部依赖并报告缺失项

### 本地编辑后更新

```bash
./setup.sh
```

### 其他机器拉取更新

```bash
./sync.sh
```

## 首次启动

打开 Neovim：

```bash
nvim
```

首次启动时，lazy.nvim 会自动安装已配置的插件。
注意查看 `:messages` 是否有错误信息。

## 验证安装

```bash
# 健康检查
nvim --headless "+checkhealth" +qa

# 启动测试（退出码 0 = 正常）
nvim --headless -u init.lua "+qa" && echo "OK"
```

## 下一步

- [快捷键](keybindings.md) - 了解默认按键映射
- [配置结构](structure.md) - 了解配置的组织方式
