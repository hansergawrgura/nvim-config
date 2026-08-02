-- init.lua
-- Entry point for Neovim configuration.
-- Loads core settings, then bootstraps lazy.nvim which auto-discovers plugin specs.

-- Ensure this config's directory is in runtimepath (supports `nvim -u init.lua`)
local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
vim.opt.rtp:prepend(config_root)

require("config")
require("config.lazy")
